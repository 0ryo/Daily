# 第18週（2027-02-13 土〜02-19 金）：UIKitアプリへのSwiftUI導入（段階2）と技術記事2

> この計画が想定する前提：App1 に SwiftUI の設定画面（段階1）が入っている。`@Observable` を扱える。週25h。

## 目標
- **App1 段階2**：SwiftUI の統計画面を追加し、UIKit の一覧と同じモデルを共有する。一覧のセルの一部を `UIHostingConfiguration` で SwiftUI にする。
- App1 バージョン 1.1 として審査に提出する。
- 技術記事2「UIKit アプリに SwiftUI を段階的に追加した記録」を公開する。
- 月1回のAIなし課題（CP5、SwiftUI の基礎）を制限時間内に解く。

## 学習項目
- `UIHostingConfiguration` による UICollectionView のセルの SwiftUI 化
- UIKit 側の変更を SwiftUI に伝える方法と、その逆（`@Observable` の共有、クロージャ、デリゲート）
- 混在した画面での Auto Layout と SwiftUI のサイズの決まり方（`sizingOptions`、セルの自動サイズ）
- 段階的に移行するときの判断基準（どの画面から移すか、移さない画面はどれか）

## 教材
- Apple「UIHostingConfiguration」https://developer.apple.com/documentation/swiftui/uihostingconfiguration
- WWDC22「Use SwiftUI with UIKit」https://developer.apple.com/videos/play/wwdc2022/10072/
- Swift Charts（統計画面で使う場合）https://developer.apple.com/documentation/charts

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| SwiftUI | CP5（AIなし課題、150分）と自己採点 | 3.0 |
| 相互運用 | 統計画面（SwiftUI）の作成とモデル共有 | 6.0 |
| 相互運用 | `UIHostingConfiguration` によるセルの SwiftUI 化 | 4.0 |
| 相互運用 | テスト・CI・バージョン 1.1 の審査提出 | 2.5 |
| 共通 | 技術記事2の執筆と公開 | 5.5 |
| 共通 | 振り返り | 1.5 |
| 共通 | 定着確認 | 1.5 |
| SwiftUI | 予備 | 1.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | **CP5（AIなし、150分）**。午後に統計画面の設計 | `CP5/`、`apps/App1/` |
| 日 | 統計画面を SwiftUI で作り、UIKit の一覧と同じモデルを共有する | `apps/App1/` |
| 月 | 一覧のセルを `UIHostingConfiguration` に置き換える | `apps/App1/` |
| 火 | 混在した画面の表示確認（縦横・文字サイズ最大・VoiceOver）とテスト | `apps/App1/` |
| 水 | バージョン 1.1 を CI → TestFlight → 審査提出 | App Store Connect |
| 木 | 技術記事2を公開する | 外部 |
| 金 | 定着確認：UIKit のメモリ管理（第3週） | `0219/` |

## 完了条件
- [ ] UIKit の一覧でデータを編集すると、SwiftUI の統計画面にすぐ反映される（逆方向も同様）。
- [ ] SwiftUI にしたセルで、制約衝突のログが出ない。
- [ ] バージョン 1.1 が審査に提出されている（または公開済み）。
- [ ] 技術記事2が公開されている。
- [ ] どの画面を SwiftUI に移し、どの画面を UIKit に残したか、その理由を記事中で説明している。
- [ ] CP5 が合計70点以上で、「動作」がレベル3以上。

## 成果物
- App1 バージョン 1.1（UIKit と SwiftUI の混在）、技術記事2

## 定着確認
- 第3週：循環参照と `weak`
