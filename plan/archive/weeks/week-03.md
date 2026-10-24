# 第3週（2026-10-31 土〜11-06 金）：画面遷移・デリゲート・メモリ管理

> この計画が想定する前提：単元4（入力と保存）を修了している。複数画面はまだ扱っていない。週25h、Xcode 27.x／iOS 27 SDK。

## 目標
- UINavigationController で一覧 → 詳細 → 編集の遷移を作り、値を渡して結果を受け取れる。
- 自作のデリゲート（protocol と weak 参照）とクロージャのどちらでも、編集結果を前の画面へ返せる。
- 循環参照が起きる条件を説明し、Memory Graph Debugger と `deinit` で解放を確かめられる。

## 学習項目
- `UINavigationController`、`pushViewController`、`popViewController`、`present`／`dismiss`、`navigationItem`（タイトル、バーボタン）
- 画面間の値渡し：イニシャライザで渡す（XIBの VC は `init(nibName:bundle:)` を使う）
- 結果の返し方：自作デリゲート（`protocol ...: AnyObject` と `weak var delegate`）とクロージャ
- メモリ管理：ARC、強参照の循環、`weak` と `unowned`、クロージャの `[weak self]`、`deinit`
- Xcode の Memory Graph Debugger の使い方

## 教材
- Apple Today チュートリアル「Adding the detail view」https://developer.apple.com/tutorials/app-dev-training/adding-the-detail-view
- The Swift Programming Language「Automatic Reference Counting」https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/
- WWDC21「Detect and diagnose memory issues」https://developer.apple.com/videos/play/wwdc2021/10180/
- Apple「UINavigationController」https://developer.apple.com/documentation/uikit/uinavigationcontroller

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| UIKit | 教材（遷移、ARC、WWDC動画） | 5.0 |
| UIKit | 毎日の課題の実装 | 8.5 |
| UIKit | 週末課題「連絡先メモ（一覧・詳細・編集）」 | 7.5 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録（遷移図を手で描いて残す） | 2.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 一覧から詳細へ push し、選んだ行のデータをイニシャライザで渡す | `1031/` |
| 日 | 週末課題「連絡先メモ」：一覧 → 詳細 → 編集（モーダル）。編集結果をデリゲートで返し、一覧と保存を更新する | `1101/` |
| 月 | 同じ機能を、クロージャで結果を返す形に書き換えた版を別の題材で作る | `1102/` |
| 火 | 循環参照を意図的に作り、`deinit` が呼ばれないことを確認し、修正する | `1103/` |
| 水 | Memory Graph Debugger で、課題1101に残っている VC がないか調べ、結果を PR に書く | `1104/`（調査記録のみ） |
| 木 | `UIAlertController` で削除確認を出し、確定したときだけ削除する | `1105/` |
| 金 | 定着確認：Codable 保存（第2週）を別題材で | `1106/` |

## 完了条件
- [ ] 一覧 → 詳細 → 編集 → 保存 → 一覧へ戻ったとき、一覧と保存ファイルの両方に変更が反映されている。
- [ ] デリゲートのプロパティを `weak` にしないと何が起きるかを、参照の矢印の図で説明できる。
- [ ] 詳細画面を閉じるたびに、その画面の `deinit` がログに出る。
- [ ] デリゲートとクロージャの使い分けの基準を、自分の言葉で1つ以上挙げられる。

## 成果物
- 週末課題「連絡先メモ」（`1101/`）

## 定着確認
- 第2週：Codable とファイル保存
