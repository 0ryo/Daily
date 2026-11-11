#!/usr/bin/env python3
"""課題ページ（カレンダー付きの HTML）を作る。

tasks/YYYY-MM-DD.md を読み、.claude/templates/task-page.html に埋め込んで書き出す。
課題文はモデルが書き直さず、このスクリプトがそのまま埋め込むので、表示にトークンを使わない。

使い方:
  python3 .claude/scripts/task_page.py                 # tasks/ のすべての課題
  python3 .claude/scripts/task_page.py tasks/2026-11-10.md   # 指定した課題だけ
  オプション: --root 記録の作業場所（既定はこのリポジトリ） --out 出力先 --today YYYY-MM-DD
  python3 .claude/scripts/task_page.py --serve         # 出力先のフォルダを http://127.0.0.1:8765/ で配る

課題の期間: 始まりはファイル名の日付。終わりは管理用の「状態」の行にある日付のうち一番遅いもの。
「状態」が実施中なら今日まで。日付がなければ1日だけ。
"""
import argparse, datetime, json, os, re, sys, tempfile
from pathlib import Path

HERE = Path(__file__).resolve().parent
TEMPLATE = HERE.parent / "templates" / "task-page.html"
DEFAULT_OUT = Path(tempfile.gettempdir()) / "swift-daily" / "tasks.html"
NAME_RE = re.compile(r"^(\d{4}-\d{2}-\d{2})(?:-[\w-]+)?\.md$")
DATE_RE = re.compile(r"\d{4}-\d{2}-\d{2}")
PORT = 8765


def field(admin, name):
    m = re.search(rf"^- {name}:\s*(.+)$", admin, flags=re.M)
    return m.group(1).strip() if m else ""


def load(path, today):
    m = NAME_RE.match(path.name)
    if not m:
        return None
    start = m.group(1)
    text = path.read_text(encoding="utf-8")
    title_m = re.search(r"^# .+$", text, flags=re.M)
    if not title_m:
        return None
    admin, body = text[:title_m.start()], text[title_m.start():]
    title = title_m.group(0)[2:].strip()
    status = field(admin, "状態")
    if "実施中" in status:
        kind, end = "doing", max(start, today)
    else:
        kind = "done" if "完了" in status else ""
        end = max([start] + DATE_RE.findall(status))
    return {
        "id": path.stem,
        "start": start,
        "end": end,
        "title": title,
        "short": re.sub(r"^(?:\d{4}-)?\d+[/-]\d+(?:（.）)?(?:の課題)?[\s：:]*", "", title),
        "status": re.sub(r"（.*$", "", status),  # 「完了（…の再提出で100点）」→「完了」
        "statusKind": kind,
        "area": field(admin, "区分"),
        "body": body,
    }


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("files", nargs="*")
    ap.add_argument("--root", default=str(HERE.parent.parent))
    ap.add_argument("--out", default=str(DEFAULT_OUT))
    ap.add_argument("--today", default=datetime.date.today().isoformat())
    ap.add_argument("--serve", action="store_true")
    args = ap.parse_args()
    if args.serve:
        serve(Path(args.out).parent)
        return

    paths = [Path(f) for f in args.files] or sorted((Path(args.root) / "tasks").glob("*.md"))
    tasks = sorted(filter(None, (load(p, args.today) for p in paths)), key=lambda t: t["start"])
    if not tasks:
        sys.exit("課題ファイルが見つかりませんでした。")

    data = json.dumps(tasks, ensure_ascii=False).replace("</", "<\\/")
    html = TEMPLATE.read_text(encoding="utf-8").replace("__TASKS_JSON__", data).replace("__TODAY__", args.today)
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(html, encoding="utf-8")
    print(f"{out}（課題 {len(tasks)} 件）")


def serve(folder):
    """課題ページを配る。ブラウザの表示欄はファイルを直接開くと静止画になるため、HTTP で配る。
    すでに同じポートで動いていれば何もしない（前の会話で動かしたサーバーをそのまま使う）。"""
    import functools, http.server
    folder.mkdir(parents=True, exist_ok=True)
    handler = functools.partial(http.server.SimpleHTTPRequestHandler, directory=str(folder))
    try:
        server = http.server.ThreadingHTTPServer(("127.0.0.1", PORT), handler)
    except OSError:
        print(f"http://127.0.0.1:{PORT}/tasks.html はすでに配っています。")
        return
    print(f"http://127.0.0.1:{PORT}/tasks.html を配っています（{folder}）。", flush=True)
    server.serve_forever()


if __name__ == "__main__":
    main()
