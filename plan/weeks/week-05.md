# 第5週（2026-11-14 土〜11-20 金）：UICollectionView（Diffable Data Source と Compositional Layout）

> この計画が想定する前提：UITableView の dataSource 方式と、コードでの Auto Layout を自力で書ける。週25h、iOS 27 SDK（最小対象は iOS 17 以上を想定）。

## 目標
- UICollectionView を Diffable Data Source と Compositional Layout で組み、追加・削除・並べ替えをアニメーション付きで反映できる。
- `CellRegistration` と `UIContentConfiguration` を使ってセルを作れる。
- 月1回のAIなし課題（CP2）を制限時間内に解く。

## 学習項目
- `UICollectionViewDiffableDataSource`、`NSDiffableDataSourceSnapshot`、`apply(_:animatingDifferences:)`
- 識別子の設計：スナップショットには値の全体ではなく ID を入れ、`reconfigureItems` で表示を更新する
- `UICollectionViewCompositionalLayout`（item・group・section）、`UICollectionLayoutListConfiguration`（リスト形式）
- `UICollectionView.CellRegistration`、`UIListContentConfiguration`
- スワイプ削除（`trailingSwipeActionsConfigurationProvider`）、セクションヘッダー

## 教材
- Apple Today チュートリアル「Creating a list view」https://developer.apple.com/tutorials/app-dev-training/creating-a-list-view
- Apple Today チュートリアル「Adding and deleting reminders」https://developer.apple.com/tutorials/app-dev-training/adding-and-deleting-reminders
- WWDC20「Advances in diffable data sources」https://developer.apple.com/videos/play/wwdc2020/10045/
- WWDC20「Modern cell configuration」https://developer.apple.com/videos/play/wwdc2020/10027/
- WWDC21「Make blazing fast lists and collection views」https://developer.apple.com/videos/play/wwdc2021/10252/

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| UIKit | 教材（Today チュートリアル、WWDC動画） | 6.0 |
| UIKit | 毎日の課題の実装 | 8.5 |
| UIKit | 週末課題「Today チュートリアルを読まずに類似の一覧を作る」 | 3.5 |
| 共通 | CP2（AIなし課題、120分）と自己採点 | 3.0 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 2.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | Today チュートリアルの一覧部分を進め、読み終えたらチュートリアルを閉じて、同じ構造を別題材（レシピ一覧）で作る | `1114/` |
| 日 | **CP2（AIなし、120分）**。内容は `checkpoints.md` を参照 | `CP2/` |
| 月 | 2列のグリッドと横スクロールのセクションを、Compositional Layout で1画面に並べる | `1116/` |
| 火 | 追加・削除・並べ替えを Snapshot で反映し、`reloadData` を使わない | `1117/` |
| 水 | ID だけをスナップショットに入れ、お気に入りの切り替えを `reconfigureItems` で反映する | `1118/` |
| 木 | 第3週の「連絡先メモ」の一覧を UITableView から UICollectionView のリストに置き換える（別ディレクトリにコピーしてから） | `1119/` |
| 金 | 定着確認：コードでの Auto Layout（第4週） | `1120/` |

## 完了条件
- [ ] 追加・削除・並べ替えのたびに、アニメーション付きで一覧が更新され、`reloadData` を1回も呼んでいない。
- [ ] 同じ内容の要素が2つあってもクラッシュしない識別子の設計になっている（理由を説明できる）。
- [ ] item・group・section の関係を図に描き、2列グリッドのレイアウトを教材を見ずに書ける。
- [ ] CP2 が合計70点以上で、「動作」がレベル3以上。

## 成果物
- 週末課題（`1114/`）とリスト置き換え版（`1119/`）

## 定着確認
- 第4週：コードでの Auto Layout と制約衝突の解消
