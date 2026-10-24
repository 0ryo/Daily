# 第7週（2026-11-28 土〜12-04 金）：Swift ConcurrencyとAPI通信

> この計画が想定する前提：MVVM とユニットテストを書ける。非同期処理は未習とする。週25h、Swift 6.4（Swift 6 言語モードの並行性チェックを有効にする）。

## 目標
- `async`/`await` と `URLSession` で公開 API から JSON を取得し、Codable で変換して画面に表示できる。
- 読み込み中・成功・空・失敗・再試行の状態を ViewModel で表し、画面を切り替えられる。
- UI の更新を `@MainActor` で行う理由と、データ競合の警告の意味を説明できる。
- 人間レビュー HR2（OSS への最初の PR）を提出する。

## 学習項目
- `async`/`await`、`Task`、`Task` のキャンセル、`async let`
- `@MainActor`、actor、`Sendable` の基本。新規プロジェクトの並行性に関するビルド設定（既定の actor 分離など）を Build Settings で確認する
- `URLSession.shared.data(from:)`、HTTP ステータスの確認、`JSONDecoder` の日付と snake_case の設定
- 通信層を protocol にして、テストでは固定の JSON を返す Stub に差し替える
- 読み込み状態を `enum LoadState { case idle, loading, loaded([Item]), empty, failed(Error) }` のように表す

## 教材
- The Swift Programming Language「Concurrency」https://docs.swift.org/swift-book/documentation/the-swift-programming-language/concurrency/
- WWDC21「Meet async/await in Swift」https://developer.apple.com/videos/play/wwdc2021/10132/
- Apple「Fetching website data into memory」https://developer.apple.com/documentation/foundation/fetching-website-data-into-memory
- Swift.org「Migrating to Swift 6」https://www.swift.org/migration/documentation/migrationguide/

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | 教材（Concurrency、WWDC動画、移行ガイド） | 5.0 |
| 共通 | 毎日の課題（async/await、通信、テスト） | 7.5 |
| UIKit | 週末課題「祝日一覧アプリ」の画面と状態表示 | 5.0 |
| 共通 | HR2：OSS の issue 選定と最初の PR | 3.0 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 3.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 週末課題「祝日一覧アプリ」：公開 API（例：holidays-jp）から祝日を取得し、UICollectionView に表示する。読み込み中・失敗・再試行を表示する | `1128/` |
| 日 | 土曜の続き。通信層を protocol にし、ViewModel の状態遷移を Stub でテストする | `1128/` |
| 月 | 2つの API を `async let` で並行に取得し、両方そろってから表示する | `1130/` |
| 火 | 画面を閉じたら通信の `Task` をキャンセルし、キャンセルされたことをログで確かめる | `1201/` |
| 水 | Swift 6 言語モードで出るデータ競合のエラーを3種類わざと出し、それぞれ直す | `1202/` |
| 木 | HR2：OSS で直せる小さな問題（ドキュメントの誤り、サンプルの不具合など）を探して PR を出す | 外部リポジトリ |
| 金 | 定着確認：MVVM とテスト（第6週） | `1204/` |

## 完了条件
- [ ] 機内モードで起動すると失敗表示と再試行ボタンが出て、通信を戻して再試行すると一覧が表示される。
- [ ] ViewModel の状態遷移（読み込み中 → 成功／空／失敗）のテストが、ネットワークに接続せずに通る。
- [ ] Swift 6 言語モードで、警告とエラーが0件でビルドできる。
- [ ] UI 更新をメインスレッド以外で行うと何が起きるかを説明できる。
- [ ] OSS への PR を1件提出している（マージされたかどうかは問わない）。

## 成果物
- 祝日一覧アプリ（`1128/`）、OSS への PR のリンク

## 定着確認
- 第6週：依存性注入とテスト用の差し替え
