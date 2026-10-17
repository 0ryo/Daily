# 第21週（2027-03-06 土〜03-12 金）：App2 実装2（お気に入り保存・テスト・CI）

> この計画が想定する前提：App2 の検索・一覧・詳細が動いている。App1 の CI 設定がある。週25h。

## 目標
- App2 のお気に入りを SwiftData で保存し、オフラインでも一覧を表示できる。
- Swift Testing で ViewModel と通信層をテストし、App1 の CI 設定を流用して App2 の CI を作る。
- Swift Concurrency の警告が0件の状態を保つ。

## 学習項目
- SwiftData と API の結果の組み合わせ（API の型と保存用の `@Model` を分ける）
- `@MainActor` と `ModelContext`、バックグラウンドでの保存を避ける理由
- Swift Testing：`@Suite`、タグ、非同期テスト（`async` のテスト関数）、`confirmation`
- `URLProtocol` を使った通信のテスト（参考）
- GitHub Actions：App1 と App2 で workflow を分けるか、共通化するかの判断

## 教材
- Apple「Swift Testing」https://developer.apple.com/documentation/testing
- Develop in Swift「Work with relationships」https://developer.apple.com/tutorials/develop-in-swift/work-with-relationships
- 第12週の自分の workflow と Fastfile

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | お気に入り（SwiftData）と一覧画面 | 6.0 |
| SwiftUI | オフライン時の表示 | 2.5 |
| 共通 | Swift Testing によるテストの追加 | 6.0 |
| 共通 | App2 の CI（GitHub Actions、Fastlane） | 4.0 |
| 相互運用 | App1 の UIKit ビューを App2 で再利用する際の整理（共通化するかの判断） | 2.0 |
| 共通 | 振り返り | 1.5 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 予備 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | お気に入りの追加・削除と、お気に入り一覧 | `apps/App2/` |
| 日 | テストの追加（正常系・異常系・境界値、非同期） | `apps/App2/` |
| 月 | オフライン時にお気に入り一覧を表示する | `apps/App2/` |
| 火 | App2 の CI（PR 時のビルド・テスト） | `.github/workflows/` |
| 水 | Fastlane の beta レーンを App2 にも用意する | `apps/App2/fastlane/` |
| 木 | Swift 6 言語モードで警告0件にする | `apps/App2/` |
| 金 | 定着確認：Combine（第8週） | `0312/` |

## 完了条件
- [ ] お気に入りに追加したリポジトリが、再起動後も機内モードで表示される。
- [ ] App2 のテストが15件以上あり、非同期のテストを含み、CI で通る。
- [ ] App1 と App2 のどちらの変更でも、それぞれの CI だけが動く。
- [ ] Swift 6 言語モードで警告とエラーが0件。

## 成果物
- App2 のお気に入り機能、テスト、CI

## 定着確認
- 第8週：Combine の `@Published` と `sink`
