#!/usr/bin/env python3
"""返答チェック（Stop フック）。

Claude が返答を書き終えた直後に、最後の返答（last_assistant_message）を機械的に確かめる。
1. 口調：感嘆符・絵文字がない、「です・ます」がない、禁止の言い回しがある
2. 番号だけの指し方：「テスト5」「要件3」「4-4-3」を括弧の外で使っている
3. 文言の違いを必須にする：必須・未達成の行で、文言・表記の違いを挙げている
4. 課題の量：想定時間に対して、作業の単位（処理の手順・関数・テスト・説明問題）が多すぎる

問題があれば {"decision": "block", "reason": ...} を返し、Claude に書き直させる。
同じ返答の書き直しで MAX_BLOCKS 回続けて止めたら、止めずに利用者へ警告だけを出す。

手動で確かめるとき： python3 answer_check.py --file 返答.md （問題があれば exit 1）
課題ファイルの検査： python3 answer_check.py --task-file tasks/YYYY-MM-DD.md
（PostToolUse では --task-hook で、tasks/ の課題ファイルを書いた直後に同じ検査をする）
"""
import io, json, os, re, sys, tempfile

MAX_BLOCKS = 3

# --- 4. 課題の量 --------------------------------------------------------
MINUTES_PER_UNIT = 5.5   # 過去の課題（11/4 は23単位で実際2時間）から決めた
TOLERANCE = 1.10         # 想定時間の10%超でエラー

# --- 1. 口調 ------------------------------------------------------------
BANNED_PHRASES = [
    "まだ終わりではありません", "1文字も違いません", "一文字も違いません",
    "今回は問題にしません", "結論から言うと", "重要なのは",
    "することができます", "することができる", "を行います", "を行う",
]
EMOJI_RE = re.compile(
    "[\U0001F300-\U0001FAFF\U00002600-\U000027BF\U00002B50\U00002B55"
    "\U0001F000-\U0001F2FF\U00002190-\U000021FF\U00002300-\U000023FF]")
POLITE_RE = re.compile(r"です|ます|ました|ません|でした|ください|でしょう")

# --- 2. 番号だけの指し方 ------------------------------------------------
NUMBER_REF_RE = re.compile(
    r"テスト\s*\d+(?:\s*[・、〜~]\s*\d+)*|要件\s*\d+(?:-\d+)*"
    r"|(?<![\d/.:\w-])\d{1,2}(?:-\d{1,2}){1,3}(?![\d/:\w-])")
# 番号の直後に名前を書いた形（課題文の見出し **2-1. と、表の「4-7. 起動時の読み込み」）
DEFINITION_MARK_RE = re.compile(
    r"\*\*\d+(?:-\d+)*\.|(?<![\d-])\d+(?:-\d+)+(?:\s*〜\s*\d+(?:-\d+)+)?\.\s*(?=[^\s\d|*])")

# --- 3. 文言の違いを必須にする ------------------------------------------
REQUIRED_RE = re.compile(r"必須|未達成|再提出の条件|直してください")
WORDING_RE = re.compile(
    r"文言|表記|句読点|読点|句点|全角|半角|コロン|スペースの|空白の数|誤字|言い回し"
    r"|大文字|小文字|絵文字|改行の位置|表示の細かい|「[^」]{1,30}」と「[^」]{1,30}」の違い")
NOT_REQUIRED_RE = re.compile(r"必須にせず|必須ではな|必須にしない|任意|減点しない|減点せず|対象外|求めない")


def strip_code(text):
    """コードブロックを消し、インラインコードを CODE に置き換える。"""
    text = re.sub(r"```.*?```", "", text, flags=re.S)
    return re.sub(r"`[^`\n]+`", "CODE", text)


def excerpt(line, limit=40):
    line = line.strip()
    return line if len(line) <= limit else line[:limit] + "…"


def check_tone(prose):
    problems = []
    if not re.search(r"[！!]", prose):
        problems.append("口調：感嘆符（！）が1つもありません。")
    if not EMOJI_RE.search(prose):
        problems.append("口調：絵文字が1つもありません。")
    if len(re.findall(r"[。！？!?]", prose)) >= 2 and not POLITE_RE.search(prose):
        problems.append("口調：「です・ます」の文がありません。")
    for phrase in BANNED_PHRASES:
        if phrase in prose:
            problems.append(f"口調：使わない言い回し「{phrase}」があります。")
    return problems


def outside_parens(line, start):
    """line[start] が （ ） や ( ) の外にあれば True。"""
    depth = 0
    for ch in line[:start]:
        if ch in "（(":
            depth += 1
        elif ch in "）)" and depth:
            depth -= 1
    return depth == 0


def check_number_refs(prose):
    problems = []
    for line in prose.splitlines():
        if line.lstrip().startswith("#"):
            continue  # 見出し
        body = DEFINITION_MARK_RE.sub("", line)
        body = re.sub(r"\d{4}-\d{2}-\d{2}", "", body)  # 日付
        for m in NUMBER_REF_RE.finditer(body):
            if outside_parens(body, m.start()):
                problems.append(
                    f"番号だけの指し方：「{m.group(0)}」で指しています（行：{excerpt(line)}）。"
                    "操作と結果、型名・関数名で書いてください。")
    return problems


def check_wording_required(prose):
    problems = []
    for line in prose.splitlines():
        if REQUIRED_RE.search(line) and WORDING_RE.search(line) and not NOT_REQUIRED_RE.search(line):
            problems.append(
                f"文言の違いを必須にしています（行：{excerpt(line)}）。"
                "表示の文言・表記の違いは必須の指摘にしません。")
    return problems


def to_minutes(s):
    m = re.search(r"([\d.]+)\s*(時間|h|分)", s)
    if not m:
        return None
    value = float(m.group(1))
    return value if m.group(2) == "分" else value * 60


def count_units(text):
    """作業の単位を数える。古い形（**2-1.** の番号とテストの表）と、
    2026-11-11 からの短い形（番号付きの処理・シグネチャ・チェックリスト）の両方を数える。"""
    q_blocks = re.findall(r"### 説明問題\n(.*?)(?=\n#{2,3} |\Z)", text, flags=re.S)
    rest = re.sub(r"### 説明問題\n.*?(?=\n#{2,3} |\Z)", "", text, flags=re.S)
    rest = re.sub(r"```.*?```", lambda m: "\n".join(
        "FUNC" for line in m.group(0).splitlines() if line.strip().startswith("func ")), rest, flags=re.S)
    steps = len(re.findall(r"\*\*\d+(?:-\d+){2,}\.\*\*", rest))
    funcs = len(re.findall(r"\*\*\d+-\d+\.\s", rest)) + len(re.findall(r"^FUNC$", rest, flags=re.M))
    tests = len(re.findall(r"^\|\s*\d+\s*\|", rest, flags=re.M)) + len(re.findall(r"^\s*- \[[ xX]\]", rest, flags=re.M))
    # 短い形の処理の1行は、古い形の「関数の見出し＋手順」の2単位にあたる（11/10 の課題で古い形22単位・短い形23単位）
    steps += 2 * len(re.findall(r"^\d+\.\s", rest, flags=re.M))
    questions = 0
    for block in q_blocks:
        numbered = len(re.findall(r"^\d+\.", block, flags=re.M))
        questions += numbered or len([l for l in block.splitlines() if re.search(r"[？?]\s*(?:［.*)?$", l)])
    return steps + funcs + tests + questions


def check_volume(text):
    m = re.search(r"想定時間[：:]\s*([^\n]+)", text)
    if not m:
        return []
    line = m.group(1)
    parts = {}
    for name in ("パート1", "パート2"):
        pm = re.search(name + r"\s*約?\s*([\d.]+\s*(?:時間|h|分))", line)
        if pm:
            parts[name] = to_minutes(pm.group(1))
    # 「2時間（パート1 約1.5時間…）」は先頭の合計を、「パート1 1.5時間／パート2 30分」はパートの和を使う
    total = to_minutes(line) if not line.lstrip().startswith("パート") else sum(parts.values())
    problems = []

    def judge(label, units, minutes):
        estimate = units * MINUTES_PER_UNIT
        if minutes and estimate > minutes * TOLERANCE:
            problems.append(
                f"課題の量：{label}は作業の単位が{units}個で、見積もりは約{estimate:.0f}分です。"
                f"想定時間の{minutes:.0f}分に収まるよう、量を減らしてください。")

    sections = re.split(r"(?m)^## ", text)
    for name, minutes in parts.items():
        body = next((s for s in sections if s.startswith(name)), "")
        judge(name, count_units(body), minutes)
    judge("課題全体", count_units(text), total)
    return problems


def check(text):
    prose = strip_code(text)
    return (check_tone(prose) + check_number_refs(prose)
            + check_wording_required(prose) + check_volume(text))


def counter_path(session_id):
    safe = re.sub(r"[^\w-]", "_", session_id or "unknown")
    return os.path.join(tempfile.gettempdir(), f"answer_check-{safe}.count")


def run_hook():
    sys.stdin = io.TextIOWrapper(sys.stdin.buffer, encoding="utf-8", errors="replace")
    data = json.load(sys.stdin)
    path = counter_path(data.get("session_id"))
    count = 0
    if data.get("stop_hook_active"):
        try:
            with open(path, encoding="utf-8") as f:
                count = int(f.read().strip() or 0)
        except (OSError, ValueError):
            count = 0
    problems = check(data.get("last_assistant_message") or "")
    if not problems:
        _remove(path)
        sys.exit(0)
    if count >= MAX_BLOCKS:
        _remove(path)
        print(json.dumps({"systemMessage":
            f"返答チェックが{MAX_BLOCKS}回続けて通らなかったため、そのまま表示しました："
            + " ".join(problems)}, ensure_ascii=False))
        sys.exit(0)
    with open(path, "w", encoding="utf-8") as f:
        f.write(str(count + 1))
    print(json.dumps({"decision": "block", "reason":
        "返答チェック（answer_check.py）で次の問題が見つかりました。"
        "直した返答を、もう一度全文で書いてください。\n- " + "\n- ".join(problems)},
        ensure_ascii=False))
    sys.exit(0)


def _remove(path):
    try:
        os.remove(path)
    except OSError:
        pass


def run_cli(path):
    with open(path, encoding="utf-8") as f:
        problems = check(f.read())
    for p in problems:
        print("- " + p)
    sys.exit(1 if problems else 0)


TASK_FILE_RE = re.compile(r"/tasks/\d{4}-\d{2}-\d{2}[^/]*\.md$")


def check_task_file(text):
    """課題ファイルの検査。口調（絵文字・感嘆符）は課題文には求めないので外す。管理用の行は見ない。"""
    m = re.search(r"^# ", text, flags=re.M)
    body = text[m.start():] if m else text
    # 課題を出したあとに足す記録の節（途中で伝えた確認・未達成の条件など）は、課題文ではないので見ない
    body = re.sub(r"(?ms)^## (?:途中で|未達成|前回から).*?(?=^## |\Z)", "", body)
    prose = strip_code(body)
    return check_number_refs(prose) + check_wording_required(prose) + check_volume(body)


def run_task_hook():
    """PostToolUse フック：Write・Edit で課題ファイル（tasks/YYYY-MM-DD.md）を書いた直後に検査する。
    課題文はチャットに貼らず課題ページで見せるので、学習者が見る前にファイルの段階で直させる。"""
    sys.stdin = io.TextIOWrapper(sys.stdin.buffer, encoding="utf-8", errors="replace")
    data = json.load(sys.stdin)
    path = (data.get("tool_input") or {}).get("file_path") or ""
    if not TASK_FILE_RE.search(path) or not os.path.isfile(path):
        sys.exit(0)
    with open(path, encoding="utf-8") as f:
        problems = check_task_file(f.read())
    if problems:
        print(json.dumps({"decision": "block", "reason":
            f"課題ファイルの検査（answer_check.py）で次の問題が見つかりました。{path} を直してください。"
            "直すまで課題ページを作らず、学習者に見せないでください。\n- " + "\n- ".join(problems)},
            ensure_ascii=False))
    sys.exit(0)


if __name__ == "__main__":
    if len(sys.argv) == 3 and sys.argv[1] == "--file":
        run_cli(sys.argv[2])
    if len(sys.argv) == 3 and sys.argv[1] == "--task-file":
        problems = check_task_file(open(sys.argv[2], encoding="utf-8").read())
        print("\n".join("- " + p for p in problems))
        sys.exit(1 if problems else 0)
    if len(sys.argv) == 2 and sys.argv[1] == "--task-hook":
        run_task_hook()
    run_hook()
