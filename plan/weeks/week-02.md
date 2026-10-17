# 第2週（2026-10-24 土〜10-30 金）：Codableによるローカル保存と失敗時の処理

> この計画が想定する前提：第1週で入力検証とPRの流れを身につけている。週25h、Xcode 27.x／Swift 6.4。

## 目標
- 単元4後半（ローカル保存）を終える。入力したデータを保存し、アプリを再起動した後に復元できる。
- 保存・読み込みに失敗したときの処理を、`throws` と `do`/`catch` で書き分けて説明できる。
- 月1回のAIなし課題（CP1）を制限時間内に解く。

## 学習項目
- `Codable`（`Encodable`/`Decodable`）、`JSONEncoder`/`JSONDecoder`、`CodingKeys`
- `FileManager` と Documents ディレクトリ、`Data.write(to:options:)`、`.atomic` を指定する理由
- UserDefaults とファイル保存の使い分け（設定値は UserDefaults、一覧データはファイル）
- エラー処理：`throws`、`do`/`catch`、`try?` と `try` の違い、独自のエラー型（`enum ... : Error`）
- 保存と表示の責務分担：保存処理をVCに書かず、保存用の型（Store）に分ける

## 教材
- Apple「Encoding and Decoding Custom Types」https://developer.apple.com/documentation/foundation/encoding-and-decoding-custom-types
- The Swift Programming Language「Error Handling」https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/
- Apple「FileManager」https://developer.apple.com/documentation/foundation/filemanager

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | 教材を読み、Codable とエラー処理を playground で試す | 4.0 |
| 共通 | 毎日の課題の実装（保存・読み込み・失敗時の処理） | 7.0 |
| UIKit | 単元4の統合課題（入力・検証・一覧・保存を組み合わせる） | 6.0 |
| 共通 | CP1（AIなし課題、90分）と自己採点 | 2.5 |
| UIKit | 人間レビューHR1の準備と参加（勉強会） | 2.0 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 2.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 単元4の統合課題「読書メモ」：タイトルと評価（1〜5）を入力して一覧に追加し、再起動後も残す | `1024/` |
| 日 | **CP1（AIなし、90分）**。内容は `checkpoints.md` を参照。午後に統合課題の続き | `CP1/`（作成前に承認を得る） |
| 月 | 構造体を JSON に変換し、元に戻す。キー名が異なる JSON は `CodingKeys` で対応する | `1026/` |
| 火 | 読み込み失敗（ファイルがない、壊れている）を区別し、初回起動時は空の一覧を表示する | `1027/` |
| 水 | 設定値（並び順）を UserDefaults に保存し、一覧データはファイルに保存する | `1028/` |
| 木 | 保存に失敗したときに、ユーザーへ伝える表示と、入力内容を消さない処理を作る | `1029/` |
| 金 | 定着確認：第1週の入力検証を、別の題材で過去コードを見ずに作る | `1030/` |

## 完了条件
- [ ] アプリを終了して再起動しても、追加したデータが同じ順番で表示される。
- [ ] 保存ファイルを削除した状態、または壊れたJSONを置いた状態で起動しても、クラッシュせず空の一覧と案内を表示する。
- [ ] `try?` を使った箇所について、失敗を無視してよい理由をコメントなしで口頭説明できる。
- [ ] 保存処理が ViewController ではなく保存用の型にある。
- [ ] CP1 をルーブリックで採点し、合計70点以上で「動作」がレベル3以上になる。

## 成果物
- 単元4の統合課題（`1024/`）。単元4の進級条件（不正な入力を拒否できる／再起動後に復元できる／失敗時の処理を説明できる）の判定に使う。

## 定着確認
- 第1週：UITextFieldDelegate による入力の制限
