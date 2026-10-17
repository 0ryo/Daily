# 第16週（2027-01-30 土〜02-05 金）：SwiftUI入門2（@Binding・リスト・入力・NavigationStack）

> この計画が想定する前提：第15週で View・レイアウト・`@State` を扱えるようになっている。週25h。

## 目標
- `@Binding` で子 View から親の状態を変更できる。
- `List`・`ForEach`・`Identifiable` で一覧を作り、追加・削除できる。
- `TextField` と `Form` で入力画面を作り、入力検証の結果でボタンを無効にできる。
- `NavigationStack` と `navigationDestination`、`sheet` で画面を遷移できる。

## 学習項目
- `@Binding` と `$` による受け渡し、状態を持つ View（Source of Truth）を1つに決める考え方
- `List`、`ForEach`、`Identifiable`、`onDelete`、`onMove`
- `TextField`、`Toggle`、`Stepper`、`Picker`、`Form`、`disabled`
- `NavigationStack`、`NavigationLink(value:)`、`navigationDestination(for:)`、`sheet`、`dismiss`（`@Environment(\.dismiss)`）

## 教材
- Develop in Swift「Create dynamic content」https://developer.apple.com/tutorials/develop-in-swift/create-dynamic-content
- Develop in Swift「Design an interface」https://developer.apple.com/tutorials/develop-in-swift/design-an-interface
- Develop in Swift「Navigate sample data」https://developer.apple.com/tutorials/develop-in-swift/navigate-sample-data
- Apple「NavigationStack」https://developer.apple.com/documentation/swiftui/navigationstack

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | 教材（Develop in Swift の3章） | 6.0 |
| SwiftUI | 毎日の課題の実装 | 8.5 |
| SwiftUI | 週末課題「買い物メモ（SwiftUI版）」 | 6.0 |
| 共通 | 振り返り（UIKit の遷移・一覧との比較） | 2.0 |
| 共通 | 定着確認 | 1.5 |
| SwiftUI | 予備 | 1.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 教材。`@Binding` で、子 View のトグルが親の表示を変える画面 | `0130/` |
| 日 | 週末課題「買い物メモ（SwiftUI版）」：1016 と同じ仕様（入力検証・一覧・追加）を SwiftUI で作る | `0131/` |
| 月 | `List` で追加・削除・並べ替え | `0201/` |
| 火 | `Form` の入力画面。不正な入力では保存ボタンを無効にする | `0202/` |
| 水 | `NavigationStack` で一覧 → 詳細、`sheet` で追加画面 | `0203/` |
| 木 | 詳細画面で `@Binding` を使って値を編集し、一覧に反映する | `0204/` |
| 金 | 定着確認：Concurrency と状態表示（第7週） | `0205/` |

## 完了条件
- [ ] 1016 と同じテストケース（空白のみ・0・100・数字以外を拒否）を、SwiftUI 版でもすべて満たす。
- [ ] 一覧 → 詳細 → 編集 → 一覧に反映、の流れを教材を見ずに作れる。
- [ ] 状態をどの View に置くか（Source of Truth）を、自分の課題の図で説明できる。
- [ ] UIKit の `pushViewController` と `NavigationStack` の違いを2つ以上挙げられる。

## 成果物
- 買い物メモ（SwiftUI版）（`0131/`）

## 定着確認
- 第7週：async/await と読み込み状態
