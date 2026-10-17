---
name: test-noai
description: 月1回の AIなし課題（CP1〜CP6）を出題する。制限時間と完了条件を示し、解答中はヒントを一切出さない。採点は「できました」（daily-review）と同じ基準で行う。「AIなし課題を出して」「月例テスト」「チェックポイントの課題」と言われたときにも使う。
when_to_use: Swift Daily リポジトリで、plan/checkpoints.md の AIなし課題を始めるとき。
allowed-tools: Read Write Edit Bash(python3 .claude/scripts/teacher_context.py *) Bash(git status *) Bash(git rev-parse *) Bash(date *) Bash(ls *)
---

# AIなし課題を出題する（test-noai）

**この課題の実施中は、ヒント・解説・API 名・方針の示唆を一切出さない。** 学習者から質問されても「AIなし課題の実施中のため答えられません。課題文の要件の意味の確認だけ受け付けます」と返す。要件の文言の意味の確認（例：「この入力は拒否するのか」）だけは、課題文に書いた範囲で答えてよい。

## 1. どの CP かを決める
1. `python3 .claude/scripts/teacher_context.py` を実行し、今日の日付・週・月を得る。
2. `plan/checkpoints.md` を読み、今月の CP を決める。すでに今月の CP の課題ファイル（`tasks/*-cpN.md`）があり状態が「完了」なら、出題せずにそのことを伝える。不合格の再挑戦（2週間以内の類題）の場合は、`-cpNr` を付けて区別する。
3. **出題するフレームワーク**は次の順に決める（UIKit と SwiftUI を月ごとに交互にするが、SwiftUI を学ぶ前は UIKit にする）。
   - 2026年10月〜2027年1月（CP1〜CP4）：UIKit（SwiftUI は第15週から学ぶため）
   - 2027年2月（CP5）：SwiftUI
   - 2027年3月（CP6）：UIKit と SwiftUI の総合（SwiftData と UIHostingController を含む）
   - 計画が修正されている場合は、直前の CP と別のフレームワークにする（ただし未習のフレームワークは出さない）。
4. 範囲は checkpoints.md のその CP の「範囲」と、これまでの progress/weakness.md の弱点から1つを含める。

## 2. 開始前の確認
1. 未コミットの変更（学習用コードの場所）があれば、先にコミットするよう促して止まる。
2. 次の準備ができているかを学習者に確認して止まる：Xcode のコーディングアシスタントと予測補完を無効にした／過去のコードを開いていない／制限時間を確保した。学習者が「始めます」と答えたら次へ進む。

## 3. 出題して記録する
1. `date "+%Y-%m-%d %H:%M"` で開始時刻を得て、締め切り（開始時刻＋制限時間）を計算する。
2. `tasks/YYYY-MM-DD-cpN.md` を次の形式で保存する。

```
# YYYY-MM-DD（曜）AIなし課題 CPN：タイトル

- 状態: 実施中
- 区分: UIKit／SwiftUI／総合
- 制限時間: NNN分
- 開始: YYYY-MM-DD HH:MM
- 締め切り: YYYY-MM-DD HH:MM
- 作業場所: `CPN/`
- 基準コミット: <HEAD の完全なハッシュ>
- 使ってよいもの: Apple の公式ドキュメント、The Swift Programming Language、Xcode の通常のコード補完
- 使ってはいけないもの: AI（Claude Code、ChatGPT、Xcode のコーディングアシスタントと予測補完）、過去の自分のコード、Web 検索で見つけたコード例

## 課題の説明と要件
## 完了条件
- [ ]
## 提出のしかた
締め切りまでにコミットし、「できました」と伝える。締め切り後のコミットと未コミットの変更は採点しない。
```

3. 課題の内容を表示する。完了条件と制限時間は必ず示す。調べるべきドキュメントのトピックは**書かない**（AIなし課題のため）。

## 4. 採点
学習者が「できました」と言ったら、daily-review の手順で採点する（締め切り前の最後のコミットを対象にする）。合否は rubric.md の AIなし課題の基準（CP1〜CP5 は合計70点以上かつ動作レベル3以上、CP6 は合計75点以上かつ動作と設計がレベル3以上）を使う。不合格なら、2週間以内に同じ範囲の類題（`-cpNr`）を出す予定を課題ファイルに書く。
