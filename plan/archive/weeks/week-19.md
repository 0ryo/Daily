# 第19週（2027-02-20 土〜02-26 金）：SwiftDataと成果物アプリ2（SwiftUI主体）の設計

> この計画が想定する前提：SwiftUI の状態管理と遷移を扱え、App1 で相互運用を経験した。SwiftData は未習。週25h。

## 目標
- SwiftData でデータを保存・取得・更新・削除し、`@Query` で一覧に表示できる。
- 成果物アプリ2（以下「App2」）の要件と設計を決め、Issue に分ける。
- 人間レビュー HR5（OSS への2件目の PR。コードの変更を含むもの）を提出する。

## App2 の必須要件（第22週に TestFlight で配信する。App Store 公開は任意）
- SwiftUI 主体。題材は「GitHub のリポジトリ検索とお気に入り」（iOS の採用課題でよく使われる題材で、他の人の実装と比べやすい）
- GitHub REST API の検索を async/await で呼ぶ。読み込み中・空・失敗・再試行を表示する
- `NavigationStack` で一覧 → 詳細。状態は `@Observable` で持つ
- お気に入りを SwiftData で保存する
- UIKit の部品を SwiftUI から使う：`UIViewControllerRepresentable`（例：`SFSafariViewController` でリポジトリを開く）と `UIViewRepresentable`（例：App1 で作った UIKit のビューを再利用する、または `UITextView` で README を表示する）
- Swift Testing によるテストと、GitHub Actions の CI

## 学習項目
- SwiftData：`@Model`、`ModelContainer`、`modelContainer(for:)`、`@Query`、`modelContext.insert`／`delete`、`#Predicate`、`SortDescriptor`
- SwiftData を使う View のプレビュー（メモリ上のコンテナ）
- GitHub REST API の検索エンドポイント、レート制限、ページング
- 参考：Core Data は既存プロジェクトで使われていることがあるため、`NSManagedObject` と `NSFetchRequest` の役割だけを読めるようにする

## 教材
- Develop in Swift「Save data」https://developer.apple.com/tutorials/develop-in-swift/save-data
- Develop in Swift「Create, update, and delete data」https://developer.apple.com/tutorials/develop-in-swift/create-update-and-delete-data
- Apple「Persisting user data」（Develop apps for Apple platforms）https://developer.apple.com/tutorials/app-dev-training/swift-data
- WWDC23「Meet SwiftData」https://developer.apple.com/videos/play/wwdc2023/10187/
- GitHub Docs「REST API endpoints for search」https://docs.github.com/rest/search/search

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | 教材（SwiftData） | 5.0 |
| SwiftUI | 毎日の課題（SwiftData） | 6.0 |
| 共通 | App2 の要件定義・画面遷移図・Issue 作成 | 4.5 |
| SwiftUI | App2 の雛形（NavigationStack と空の画面、SwiftData のコンテナ） | 3.5 |
| 共通 | HR5：OSS への2件目の PR | 3.0 |
| 共通 | 振り返り | 1.5 |
| 共通 | 定着確認 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 教材。SwiftData で読書メモ（第2週と同じ題材）を作り直す | `0220/` |
| 日 | App2 の要件定義・画面遷移図・Issue | `apps/App2/docs/` |
| 月 | `#Predicate` と `SortDescriptor` で絞り込みと並べ替え | `0222/` |
| 火 | App2 の雛形（起動できる状態） | `apps/App2/` |
| 水 | HR5：OSS の issue を選び、コードの変更を含む PR を出す | 外部リポジトリ |
| 木 | Codable による保存（第2週）と SwiftData の違いを表にまとめ、PR に書く | `0225/` |
| 金 | 定着確認：Compositional Layout（第5週） | `0226/` |

## 完了条件
- [ ] SwiftData の読書メモで、追加・編集・削除のあと再起動しても内容が残る。
- [ ] `@Query` を使う一覧のプレビューが、メモリ上のコンテナで表示される。
- [ ] App2 の要件それぞれに受け入れ条件があり、Issue が第20〜22週に割り振られている。
- [ ] OSS への2件目の PR（コードの変更を含む）を提出している。

## 成果物
- `apps/App2/`（雛形と設計資料）、OSS への PR のリンク

## 定着確認
- 第5週：Compositional Layout
