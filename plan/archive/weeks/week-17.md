# 第17週（2027-02-06 土〜02-12 金）：@Observable と UIKitアプリへのSwiftUI導入（段階1）

> この計画が想定する前提：SwiftUI で一覧・入力・遷移を作れる。App1（UIKit）は公開済み。実務で最も多い「既存の UIKit アプリに SwiftUI を足す」状況を App1 で練習する。週25h。

## 目標
- `@Observable` のクラスで状態を持ち、複数の View で共有できる（`@Environment`、`@Bindable`）。
- **App1 に、UIHostingController で SwiftUI の設定画面を1つ追加する（段階1）**。UIKit の画面から push で開き、設定値を UIKit 側に反映する。

## 段階的導入の計画（第17〜18週）
| 段階 | 週 | 内容 | UIKit 側に残すもの |
|---|---|---|---|
| 1 | 第17週 | 設定画面を SwiftUI で新規作成し、UIHostingController で push する | 一覧・詳細・編集 |
| 2 | 第18週 | 統計画面を SwiftUI で作り、UIKit 側と同じモデル（`@Observable`）を共有する。一覧のセルの一部を `UIHostingConfiguration` で SwiftUI にする | 一覧の画面構成・編集 |
| 3（任意） | 第23週以降 | 編集画面を SwiftUI に置き換えるかを、工数と効果で判断する（判断の記録だけでもよい） | 判断次第 |

## 学習項目
- Observation：`@Observable`、`@State` で所有する、`@Environment` で渡す、`@Bindable` で Binding を作る
- `UIHostingController(rootView:)`、`navigationController?.pushViewController`、SwiftUI 側からの戻り方
- UIKit と SwiftUI で同じモデルを参照するときの注意（どちらが所有するか、変更の通知）
- SwiftUI の画面だけを先に `#Preview` で作り、後から UIKit に組み込む手順

## 教材
- Apple「Making classes observable」（Develop apps for Apple platforms）https://developer.apple.com/tutorials/app-dev-training/making-classes-observable
- WWDC23「Discover Observation in SwiftUI」https://developer.apple.com/videos/play/wwdc2023/10149/
- WWDC22「Use SwiftUI with UIKit」https://developer.apple.com/videos/play/wwdc2022/10072/
- Apple「UIHostingController」https://developer.apple.com/documentation/swiftui/uihostingcontroller

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | 教材（Observation） | 3.5 |
| SwiftUI | 毎日の課題（`@Observable`、`@Environment`、`@Bindable`） | 7.5 |
| 相互運用 | 教材（WWDC22「Use SwiftUI with UIKit」） | 2.0 |
| 相互運用 | App1 に SwiftUI の設定画面を追加（段階1） | 8.0 |
| 共通 | 振り返り | 2.5 |
| 共通 | 定着確認 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | `@Observable` のモデルを2つの画面で共有し、片方の変更がもう片方に反映されることを確かめる | `0206/` |
| 日 | App1 段階1：設定画面を SwiftUI で作り、`#Preview` で確認する | `apps/App1/` |
| 月 | App1 段階1：UIHostingController で一覧画面から push し、設定値を UIKit 側に反映する | `apps/App1/` |
| 火 | `@Environment` で親から孫の View にモデルを渡す | `0209/` |
| 水 | `@Bindable` で、`@Observable` のプロパティを `TextField` に結び付ける | `0210/` |
| 木 | App1 段階1のテスト（設定値の保存と反映）と PR | `apps/App1/` |
| 金 | 定着確認：RxSwift（第8週） | `0212/` |

## 完了条件
- [ ] App1 の一覧画面から SwiftUI の設定画面を開き、設定を変えて戻ると、一覧の表示に反映される。
- [ ] 設定画面を閉じたとき、UIHostingController と関係するオブジェクトが解放される（`deinit` またはメモリグラフで確認する）。
- [ ] `@State`・`@Binding`・`@Observable`・`@Environment`・`@Bindable` の使い分けを、表にして説明できる。
- [ ] App1 の CI が成功している。

## 成果物
- App1 の段階1（SwiftUI の設定画面）

## 定着確認
- 第8週：RxSwift のバインド
