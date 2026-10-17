#!/usr/bin/env python3
"""PreToolUse フック: 学習用コードの場所への書き込みをブロックする。

先生役（Claude Code）が書いてよいのは ALLOWED_DIRS と ALLOWED_FILES だけ。
リポジトリ内のそれ以外（MMDD/、*.playground/、CPn/、apps/、.github/ など）は
学習者のコードとして扱い、Write・Edit・NotebookEdit と、Bash による書き込みを止める。
リポジトリの外（スクラッチ領域など）への書き込みは対象外。

Bash の判定は字句解析による近似で、すべての書き込み方法は防げない。
"""
import json
import os
import re
import shlex
import sys

ALLOWED_DIRS = {"tasks", "reviews", "progress", ".claude", "plan"}
ALLOWED_FILES = {"CLAUDE.md", "README.md"}

# 作業ツリーの学習者の変更を消したり退避したりする git 操作
BLOCKED_GIT = [
    ("stash",),
    ("restore",),
    ("clean",),
    ("reset", "--hard"),
    ("checkout", "--"),
    ("checkout", "."),
]

# 引数のすべてが書き込み先になるコマンド
ALL_ARGS_WRITE = {"rm", "rmdir", "touch", "mkdir", "tee", "truncate", "unlink", "chmod"}
# 最後の引数が書き込み先になるコマンド（mv は移動元も消えるので全引数を見る）
LAST_ARG_WRITE = {"cp", "ln", "rsync", "install", "ditto"}
SEGMENT_BREAKS = {";", "&&", "||", "|", "&", "(", ")", "\n"}
REDIRECTS = {">", ">>", ">|", "&>", "&>>"}


def block(reason: str) -> None:
    sys.stderr.write(
        "学習用コードの場所への書き込みはブロックされています（先生役はコードを書かない・直さない）。\n"
        f"理由: {reason}\n"
        "書いてよい場所: tasks/ reviews/ progress/ .claude/ plan/ CLAUDE.md README.md\n"
    )
    sys.exit(2)


def project_dir(payload: dict) -> str:
    root = os.environ.get("CLAUDE_PROJECT_DIR") or payload.get("cwd") or os.getcwd()
    return os.path.realpath(root)


def resolve(path: str, cwd: str) -> str:
    path = os.path.expanduser(path)
    if not os.path.isabs(path):
        path = os.path.join(cwd, path)
    return os.path.realpath(path)


def is_protected(path: str, cwd: str, root: str) -> bool:
    """リポジトリ内で、許可リストに入っていない場所なら True。"""
    path = os.path.expandvars(path)
    if "$" in path or "`" in path:
        # シェル内だけの変数やコマンド置換は、フックからは展開できないため判定しない
        return False
    full = resolve(path, cwd)
    if full != root and not full.startswith(root + os.sep):
        return False
    rel = os.path.relpath(full, root)
    if rel == ".":
        return True
    first = rel.split(os.sep)[0]
    if first in ALLOWED_DIRS:
        return False
    if rel in ALLOWED_FILES:
        return False
    return True


def check_file_tool(payload: dict, root: str) -> None:
    tool_input = payload.get("tool_input") or {}
    path = tool_input.get("file_path") or tool_input.get("notebook_path")
    if not path:
        return
    cwd = payload.get("cwd") or root
    if is_protected(path, cwd, root):
        block(f"{payload.get('tool_name')} で {path} を変更しようとしました")


HEREDOC = re.compile(r"<<-?\s*(['\"]?)(\w+)\1")


def strip_heredocs(command: str) -> str:
    """ヒアドキュメントの本文（コミットメッセージなど）は入力データなので、判定から除く。"""
    lines = command.split("\n")
    result, terminator = [], None
    for line in lines:
        if terminator is not None:
            if line.strip() == terminator:
                terminator = None
            continue
        result.append(line)
        match = HEREDOC.search(line)
        if match:
            terminator = match.group(2)
    return "\n".join(result)


def tokenize(command: str) -> list:
    # 改行はコマンドの区切りとして扱う（ヒアドキュメントの後の行も別のコマンドとして判定する）
    command = strip_heredocs(command).replace("\n", " ;\n")
    lexer = shlex.shlex(command, posix=True, punctuation_chars=";&|<>()")
    lexer.whitespace_split = True
    lexer.commenters = ""
    try:
        return list(lexer)
    except ValueError:
        # 引用符の対応が取れない場合は空白で分割して近似する
        return command.split()


def split_segments(tokens: list) -> list:
    segments, current = [], []
    for token in tokens:
        if token in SEGMENT_BREAKS:
            if current:
                segments.append(current)
            current = []
        else:
            current.append(token)
    if current:
        segments.append(current)
    return segments


def operands(args: list) -> list:
    return [a for a in args if not a.startswith("-") and a not in REDIRECTS]


def check_bash(payload: dict, root: str) -> None:
    command = (payload.get("tool_input") or {}).get("command") or ""
    cwd = payload.get("cwd") or root
    tokens = tokenize(command)

    for segment in split_segments(tokens):
        # リダイレクトの書き込み先（例: echo x > 1016/a.swift）を取り出し、引数から除く
        rest = []
        i = 0
        while i < len(segment):
            token = segment[i]
            if token in REDIRECTS and i + 1 < len(segment):
                target = segment[i + 1]
                if not target.startswith("&") and target != "/dev/null" and is_protected(target, cwd, root):
                    block(f"リダイレクトで {target} に書き込もうとしました")
                i += 2
                continue
            rest.append(token)
            i += 1
        segment = rest

        # 先頭の環境変数の代入（A=1 cmd）や sudo を読み飛ばす
        while segment and ("=" in segment[0] and not segment[0].startswith("-") or segment[0] == "sudo"):
            segment = segment[1:]
        if not segment:
            continue
        name = os.path.basename(segment[0])
        args = segment[1:]

        # cd は以降のセグメントの基準ディレクトリを変える
        if name == "cd":
            target = os.path.expandvars(args[0]) if args else os.path.expanduser("~")
            if "$" not in target:
                cwd = resolve(target, cwd)
            continue

        if name == "git":
            sub = list(args)
            # -C <path> や -c <key=value> などのグローバルオプションを読み飛ばす
            while sub and sub[0].startswith("-"):
                sub = sub[2:] if sub[0] in ("-C", "-c") else sub[1:]
            for pattern in BLOCKED_GIT:
                if tuple(sub[: len(pattern)]) == pattern:
                    block(f"git {' '.join(pattern)} は学習者の作業ツリーを変更します")
            continue

        targets = []
        if name in ALL_ARGS_WRITE or name == "mv":
            targets = operands(args)
        elif name in LAST_ARG_WRITE:
            ops = operands(args)
            targets = ops[-1:] if ops else []
        elif name in ("sed", "perl") and any(a == "-i" or a.startswith("-i") for a in args):
            targets = operands(args)[1:]
        elif name == "dd":
            targets = [a[3:] for a in args if a.startswith("of=")]

        for target in targets:
            if is_protected(target, cwd, root):
                block(f"{name} で {target} を変更しようとしました")


def main() -> None:
    try:
        payload = json.load(sys.stdin)
    except json.JSONDecodeError:
        sys.exit(0)
    root = project_dir(payload)
    tool = payload.get("tool_name")
    if tool in ("Write", "Edit", "NotebookEdit"):
        check_file_tool(payload, root)
    elif tool == "Bash":
        check_bash(payload, root)
    sys.exit(0)


if __name__ == "__main__":
    main()
