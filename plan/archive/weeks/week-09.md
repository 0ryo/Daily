# 第9週（2026-12-12 土〜12-18 金）：成果物アプリ1（UIKit主体）の企画・設計

> この計画が想定する前提：第1〜8週の UIKit・保存・MVVM・テスト・Concurrency・RxSwift を一通り書ける。成果物アプリ1は `apps/` 以下に置く（ディレクトリ作成前に承認を得る）。週25h。

## 目標
- 成果物アプリ1（以下「App1」）の要件・画面遷移・データモデル・モジュール構成を決め、GitHub の Issue に作業を分ける。
- Swift Package（ローカルパッケージ）にモデル層を切り出し、アプリ本体とテストから使える形にする。
- 月1回のAIなし課題（CP3）を制限時間内に解く。
- 人間レビュー HR3（App1 の設計を人に見てもらう）を行う。

## App1 の必須要件（第14週までに App Store で公開する）
- UIKit 主体。一覧（Diffable Data Source と Compositional Layout）、詳細、追加・編集（入力検証つき）、削除
- 画面遷移は UINavigationController。画面間の結果の受け渡しにデリゲートまたはクロージャを使う
- データは Codable とファイルで保存し、再起動後に復元する
- 外部 API を1つ以上、async/await で使う（失敗時の表示と再試行を含む）
- 検索またはフィルタの入力を RxSwift でバインドする（入社先の技術に合わせる）
- 後の週で、設定画面（第17週）と統計画面（第18週）を SwiftUI で追加できる構成にしておく
- 題材の候補：①祝日 API を使い、休日を除いた連続記録を数える習慣トラッカー ②勉強時間の記録と科目別の集計 ③自分で提案する題材（App Store 審査ガイドライン 4.2「最低限の機能」に当たらない程度の実用性が必要）

## 学習項目
- 要件定義の書き方（ユーザーストーリー、受け入れ条件）
- 画面遷移図とデータモデル図
- Swift Package Manager：ローカルパッケージの作成、ターゲットとテストターゲット、アクセス修飾子（`public`）
- GitHub Issue と Milestone で作業を分ける。1 Issue = 1 PR の粒度
- App Store 審査ガイドラインの、個人開発で落ちやすい項目（4.2 最低限の機能、5.1 プライバシー）

## 教材
- Apple「App Review Guidelines」https://developer.apple.com/app-store/review/guidelines/
- Apple「Organizing your code with local packages」https://developer.apple.com/documentation/xcode/organizing-your-code-with-local-packages
- Apple Human Interface Guidelines https://developer.apple.com/design/human-interface-guidelines/
- Develop in Swift「Explore the app design cycle」https://developer.apple.com/tutorials/develop-in-swift/explore-the-app-design-cycle

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | CP3（AIなし課題、150分）と自己採点 | 3.0 |
| 共通 | 要件定義・画面遷移図・データモデル | 5.0 |
| 共通 | 教材（審査ガイドライン、SPM、HIG） | 3.0 |
| UIKit | プロジェクトの雛形作成（ナビゲーション、空の画面、ローカルパッケージ） | 6.0 |
| 共通 | Issue の作成と見積もり | 2.0 |
| 共通 | HR3：設計レビューの依頼と反映 | 2.5 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 2.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | **CP3（AIなし、150分）**。午後に題材の決定と要件定義 | `CP3/`、`apps/App1/docs/` |
| 日 | 画面遷移図・データモデル・API 調査。Issue を10件以上作る | `apps/App1/docs/` |
| 月 | Xcode プロジェクトとローカルパッケージ（モデル層）を作る | `apps/App1/` |
| 火 | モデル層の型とテストをパッケージに書く | `apps/App1/` |
| 水 | ナビゲーションと空の画面をつなぎ、起動できる状態にする | `apps/App1/` |
| 木 | HR3：設計資料を人に見せ、指摘を Issue にする | `apps/App1/docs/` |
| 金 | 定着確認：RxSwift のバインドと DisposeBag（第8週） | `1218/` |

## 完了条件
- [ ] 要件定義に、必須要件それぞれの受け入れ条件（確認方法）が書いてある。
- [ ] 画面遷移図とデータモデル図があり、Issue が第10〜13週に割り振られている。
- [ ] ローカルパッケージのテストが `⌘U` で通る。
- [ ] App1 がシミュレータと実機（自分の iPhone）で起動する。
- [ ] CP3 が合計70点以上で、「動作」がレベル3以上。
- [ ] 設計について、自分以外の人から1件以上の指摘またはコメントをもらっている。

## 成果物
- `apps/App1/`（雛形と設計資料）

## 定着確認
- 第8週：RxSwift のバインドと循環参照
