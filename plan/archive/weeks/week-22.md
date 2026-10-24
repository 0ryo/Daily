# 第22週（2027-03-13 土〜03-19 金）：App2 仕上げ・TestFlight配信・技術記事3

> この計画が想定する前提：App2 の主要機能・テスト・CI がそろっている。Apple Developer Program は有効。週25h。

## 目標
- App2 のアクセシビリティとエラー表示を仕上げ、TestFlight で配信する（App Store 公開は任意。審査ガイドライン 4.2 に当たる可能性を自分で判断する）。
- Firebase Remote Config で、アプリを更新せずに表示を切り替えられることを示す（任意。時間が足りなければ Analytics だけでもよい）。
- 技術記事3（SwiftUI と Swift Concurrency の設計、または UIKit との比較）を公開する。

## 学習項目
- SwiftUI のアクセシビリティ：`accessibilityLabel`、`accessibilityElement(children:)`、Dynamic Type、VoiceOver の確認
- TestFlight の外部テスト（ベータ版の審査がある）
- Firebase Remote Config の取得と既定値（任意）
- README の書き方：機能・スクリーンショット・設計図・使っている技術・テストと CI のバッジ

## 教材
- Develop in Swift「Add inclusive features」https://developer.apple.com/tutorials/develop-in-swift/add-inclusive-features
- Develop in Swift「Get your beta app ready for testing」https://developer.apple.com/tutorials/develop-in-swift/get-your-beta-app-ready-for-testing
- Firebase「Get started with Remote Config」https://firebase.google.com/docs/remote-config/get-started?platform=ios

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | アクセシビリティとエラー表示の仕上げ | 5.0 |
| 共通 | TestFlight 配信（外部テストの申請を含む） | 3.0 |
| 共通 | Firebase（Analytics、任意で Remote Config） | 3.5 |
| 共通 | 技術記事3の執筆と公開 | 6.0 |
| 共通 | App1・App2 の README 整備 | 3.0 |
| 共通 | 振り返り | 1.5 |
| 共通 | 定着確認 | 1.5 |
| SwiftUI | 予備 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | VoiceOver と Dynamic Type の確認・修正 | `apps/App2/` |
| 日 | 技術記事3の下書き。TestFlight へアップロード | 外部、`apps/App2/` |
| 月 | Firebase の導入（Analytics、任意で Remote Config） | `apps/App2/` |
| 火 | TestFlight の外部テストを申請し、知人に配る | App Store Connect |
| 水 | App1・App2 の README を整える | `apps/App1/`、`apps/App2/` |
| 木 | 技術記事3を公開する | 外部 |
| 金 | 定着確認：SwiftUI の `@Binding` と遷移（第16週） | `0319/` |

## 完了条件
- [ ] App2 が TestFlight で配信され、自分以外の1人以上がインストールしている。
- [ ] VoiceOver だけで、検索・詳細表示・お気に入り登録ができる。
- [ ] 技術記事3が公開され、README から記事にリンクしている。
- [ ] App1・App2 の README に、使った技術・設計図・テストの実行方法・CI の状態が書いてある。

## 成果物
- TestFlight で配信した App2、技術記事3、整備した README

## 定着確認
- 第16週：SwiftUI の `@Binding` と `NavigationStack`
