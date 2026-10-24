#!/usr/bin/env python3
"""先生役のスキルが最初に実行する、現在の状況の要約。

出力：今日の日付と曜日、計画上の週、基準の学習時間、HEAD のコミット、
未コミットの変更（学習用コードの場所と記録ファイルに分ける）、直近の課題とレビュー。
ファイルは一切変更しない。
"""
import datetime as dt
import os
import re
import subprocess
import sys

START = dt.date(2026, 10, 17)  # 第1週の初日（土）
END = dt.date(2027, 3, 31)
RECORD_DIRS = ("tasks/", "reviews/", "progress/", ".claude/", "plan/")
RECORD_FILES = ("CLAUDE.md", "README.md")
WEEKDAYS = "月火水木金土日"


def git(*args: str) -> str:
    result = subprocess.run(["git", *args], capture_output=True, text=True)
    return result.stdout.strip()


def is_record(path: str) -> bool:
    return path.startswith(RECORD_DIRS) or path in RECORD_FILES


def main() -> None:
    root = git("rev-parse", "--show-toplevel") or os.getcwd()
    os.chdir(root)

    today = dt.date.today()
    if len(sys.argv) > 1:
        today = dt.date.fromisoformat(sys.argv[1])
    week = (today - START).days // 7 + 1
    hours = 6.5 if today.weekday() >= 5 else 2.5
    print(f"今日: {today.isoformat()}（{WEEKDAYS[today.weekday()]}）")
    if START <= today <= END:
        path = f"plan/short-term/week-{week:02d}.md"
        note = "" if os.path.exists(path) else "（まだない。/week で作る）"
        print(f"計画上の週: 第{week}週 → 短期目標 {path}{note}")
    else:
        print("計画上の週: 計画期間（2026-10-17〜2027-03-31）の外")
    print(f"基準の学習時間: {hours}h（平日2.5h、土日6.5h）")
    print(f"月: {today.month}月 → 中期目標 plan/goals.md の「{today.month}月」")

    print(f"ブランチ: {git('branch', '--show-current')}")
    print(f"HEAD: {git('rev-parse', 'HEAD')}（{git('log', '-1', '--format=%h %s')}）")

    status = git("status", "--porcelain", "--untracked-files=all")
    learner, records = [], []
    for line in status.splitlines():
        path = line[3:].split(" -> ")[-1].strip('"')
        (records if is_record(path) else learner).append(line)
    print(f"未コミットの変更（学習用コードの場所）: {len(learner)}件")
    for line in learner[:20]:
        print(f"  {line}")
    if len(learner) > 20:
        print(f"  ...ほか{len(learner) - 20}件")
    print(f"未コミットの変更（記録・設定ファイル）: {len(records)}件")
    for line in records[:10]:
        print(f"  {line}")

    for directory in ("tasks", "reviews"):
        files = sorted(
            f for f in os.listdir(directory) if f.endswith(".md")
        ) if os.path.isdir(directory) else []
        print(f"直近の {directory}/: " + ("なし" if not files else ""))
        for name in files[-3:]:
            state = ""
            with open(os.path.join(directory, name), encoding="utf-8") as fh:
                for text in fh:
                    match = re.match(r"-\s*状態[:：]\s*(.+)", text.strip())
                    if match:
                        state = match.group(1)
                        break
            print(f"  {directory}/{name}" + (f"（状態: {state}）" if state else ""))


if __name__ == "__main__":
    main()
