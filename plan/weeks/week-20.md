# 第20週（2027-02-27 土〜03-05 金）：App2 実装1（検索・一覧・詳細とUIKit部品の利用）

> この計画が想定する前提：App2 の設計と雛形ができている。SwiftUI・SwiftData・async/await を扱える。週25h。

## 目標
- App2 の検索・一覧・詳細を、`@Observable` の ViewModel と async/await で実装する。
- `UIViewControllerRepresentable` と `UIViewRepresentable` で、SwiftUI から UIKit の部品を使える。

## 学習項目
- SwiftUI での非同期処理：`.task`、`.task(id:)`（検索語が変わったら前の処理を取り消す）、`.refreshable`、`.searchable`
- 状態の表現（第7週の `LoadState` を SwiftUI で使う）と `ContentUnavailableView`
- `UIViewControllerRepresentable`：`makeUIViewController`、`updateUIViewController`
- `UIViewRepresentable`：`makeUIView`、`updateUIView`、`Coordinator` でデリゲートを受け取る
- ページング（一覧の末尾に来たら次のページを読む）

## 教材
- Apple「UIViewControllerRepresentable」https://developer.apple.com/documentation/swiftui/uiviewcontrollerrepresentable
- Apple「UIViewRepresentable」https://developer.apple.com/documentation/swiftui/uiviewrepresentable
- Apple「Managing structured concurrency」（Develop apps for Apple platforms）https://developer.apple.com/tutorials/app-dev-training/managing-structured-concurrency

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | 検索画面（`.searchable`、`.task(id:)`、状態表示） | 6.0 |
| 共通 | 通信層（GitHub API）とテスト | 4.0 |
| SwiftUI | 一覧・詳細・ページング | 5.0 |
| 相互運用 | `UIViewControllerRepresentable`（SFSafariViewController） | 2.5 |
| 相互運用 | `UIViewRepresentable` と `Coordinator` | 3.0 |
| 共通 | 振り返り | 1.5 |
| 共通 | 定着確認 | 1.5 |
| SwiftUI | 予備 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 通信層と Stub によるテスト。検索画面の状態表示 | `apps/App2/` |
| 日 | 一覧・詳細・ページング | `apps/App2/` |
| 月 | 検索語を素早く変えたときに、古い結果が表示されないことを確かめる（`.task(id:)`） | `apps/App2/` |
| 火 | SFSafariViewController を `UIViewControllerRepresentable` で表示する | `apps/App2/` |
| 水 | `UIViewRepresentable` と `Coordinator` で UIKit のビューを表示し、デリゲートの通知を SwiftUI 側で受け取る | `apps/App2/` |
| 木 | レート制限（HTTP 403）のときの表示 | `apps/App2/` |
| 金 | 定着確認：Swift Testing（第6週） | `0305/` |

## 完了条件
- [ ] 検索語を連続で変えても、最後の検索語の結果だけが表示される。
- [ ] 機内モード・0件・レート制限の3つで、それぞれ異なる表示になる。
- [ ] `makeUIView` と `updateUIView` が呼ばれるタイミングを、ログで確かめて説明できる。
- [ ] `Coordinator` が必要になる理由を説明できる。
- [ ] 通信層と ViewModel のテストが通る。

## 成果物
- App2 の検索・一覧・詳細

## 定着確認
- 第6週：Swift Testing のパラメータ化テスト
