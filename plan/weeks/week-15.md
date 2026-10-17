# 第15週（2027-01-23 土〜01-29 金）：SwiftUI入門1（View・レイアウト・@State）

> この計画が想定する前提：SwiftUI は初歩から学ぶ（以前の SwiftUI 制作物は AI が書いたため、既習として扱わない）。UIKit の知識はある。週25h、Xcode 27.x。

## 目標
- SwiftUI の View が「状態から画面を作る関数」であることを、UIKit の「画面を命令で書き換える」方式と比べて説明できる。
- `VStack`・`HStack`・`ZStack`・modifier を使い、簡単な画面を教材を見ずに組める。
- `@State` とボタンで状態を変え、画面が自動で更新されることを確かめる。
- 月1回のAIなし課題（CP4、UIKit の総合）を制限時間内に解く。

## 学習項目
- `struct ... : View`、`body`、`some View`
- `Text`、`Image`（SF Symbols）、`Button`、`Spacer`、`Divider`
- `VStack`・`HStack`・`ZStack`、`padding`、`frame`、`foregroundStyle`、`font`、modifier の順番による違い
- `@State`、状態の変更による再描画、`#Preview`
- 小さな View への分割と、プロパティで値を渡す方法

## 教材
- Develop in Swift「Hello, SwiftUI」https://developer.apple.com/tutorials/develop-in-swift/hello-swiftui
- Develop in Swift「Customize views with properties」https://developer.apple.com/tutorials/develop-in-swift/customize-views-with-properties
- Develop in Swift「Update the UI with state」https://developer.apple.com/tutorials/develop-in-swift/update-the-ui-with-state
- Apple「Introducing SwiftUI」https://developer.apple.com/tutorials/swiftui

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| UIKit | CP4（AIなし課題、150分）と自己採点 | 3.0 |
| SwiftUI | 教材（Develop in Swift の3章） | 7.0 |
| SwiftUI | 毎日の課題の実装 | 8.0 |
| SwiftUI | 週末課題「プロフィールカード」 | 3.5 |
| 共通 | 振り返り（UIKit との対応表を作る） | 2.0 |
| 共通 | 定着確認 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | **CP4（AIなし、150分）**。午後に Develop in Swift「Hello, SwiftUI」 | `CP4/`、`0123/` |
| 日 | 教材の残り。週末課題「プロフィールカード」：画像・名前・紹介文・ボタンを並べたカードを作る | `0124/` |
| 月 | カウンター：`@State` で数を増減し、0未満にならないようにする | `0125/` |
| 火 | 同じ部品を3回使う画面を、小さな View に分けて作る | `0126/` |
| 水 | modifier の順番（`padding` と `background`）を入れ替えて違いを確かめ、理由を書く | `0127/` |
| 木 | 以前の UIKit 課題（1016 の買い物メモ）の画面を、SwiftUI で見た目だけ再現する | `0128/` |
| 金 | 定着確認：UIKit のライフサイクル（第1週） | `0129/` |

## 完了条件
- [ ] `VStack`・`HStack`・`ZStack` を組み合わせた画面を、教材を見ずに作れる。
- [ ] `@State` を付けないと値を変えられない理由を説明できる。
- [ ] UIKit と SwiftUI の対応表（UILabel → Text など10項目以上）を自分で作っている。
- [ ] CP4 が合計70点以上で、「動作」がレベル3以上。

## 成果物
- SwiftUI の基礎課題（`0124/`〜`0128/`）、UIKit と SwiftUI の対応表

## 定着確認
- 第1週：UIKit のライフサイクル
