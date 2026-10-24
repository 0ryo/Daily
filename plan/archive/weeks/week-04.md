# 第4週（2026-11-07 土〜11-13 金）：コードでのAuto LayoutとStoryboardの読み方

> この計画が想定する前提：XIB で制約を付けた経験はあるが、コードでの制約指定と Storyboard の読み方は未習。週25h、Xcode 27.x。

## 目標
- XIB を使わず、コードだけで画面を組み立てられる（`NSLayoutConstraint` と anchor）。
- コンソールに出る制約の衝突（Unable to simultaneously satisfy constraints）を読み、原因の制約を特定して直せる。
- Storyboard（segue、Storyboard ID）で書かれた既存画面を読み、どの VC がどう遷移するか説明できる。

## 学習項目
- `translatesAutoresizingMaskIntoConstraints = false`、`NSLayoutConstraint.activate`、`safeAreaLayoutGuide`、`layoutMarginsGuide`
- 優先度（priority）、Content Hugging、Compression Resistance、`intrinsicContentSize`
- 制約衝突のログの読み方、`identifier` を付けて衝突を見つけやすくする方法、View Debugger
- UIStackView をコードで組む、UIScrollView の `contentLayoutGuide` と `frameLayoutGuide`
- Storyboard：segue、`prepare(for:sender:)`、`instantiateViewController(withIdentifier:)`、Unwind segue を読める程度
- 縦横回転と Dynamic Type（`adjustsFontForContentSizeCategory`）でレイアウトが崩れないか確かめる

## 教材
- Apple「Auto Layout Guide」（アーカイブだが概念は現行と同じ）https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/
- Apple「NSLayoutAnchor」https://developer.apple.com/documentation/uikit/nslayoutanchor
- Apple「UIScrollView」https://developer.apple.com/documentation/uikit/uiscrollview
- Apple「Debugging Auto Layout」（同ガイド内）

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| UIKit | 教材とコードでの制約の練習 | 5.0 |
| UIKit | 毎日の課題の実装 | 8.5 |
| UIKit | 週末課題「プロフィール画面をコードだけで作る」 | 6.5 |
| UIKit | Storyboard で書かれたサンプルを読む練習 | 1.5 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 2.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | XIB で作った過去の画面（例：1016）と同じ見た目を、コードだけで作る | `1107/` |
| 日 | 週末課題「プロフィール画面」：スクロールでき、縦横・文字サイズ最大でも崩れない画面をコードだけで作る | `1108/` |
| 月 | わざと制約を衝突させ、ログから原因の制約を特定して直し、手順を PR に書く | `1109/` |
| 火 | Hugging と Compression Resistance で、2つのラベルのどちらを縮めるかを制御する | `1110/` |
| 水 | 先生役が渡す Storyboard 構成の説明文（segue 名・遷移先）を読み、遷移図を描く。その遷移をコードで再現する | `1111/` |
| 木 | `keyboardLayoutGuide` と UIScrollView を組み合わせた入力画面 | `1112/` |
| 金 | 定着確認：デリゲートで結果を返す遷移（第3週） | `1113/` |

## 完了条件
- [ ] 週末課題を、縦向き・横向き・文字サイズ最大（Accessibility の最大値）で表示し、制約衝突のログが1件も出ない。
- [ ] 制約衝突のログを渡されたら、10分以内に原因の制約を特定できる。
- [ ] `translatesAutoresizingMaskIntoConstraints` を `false` にする理由を説明できる。
- [ ] Storyboard の segue を使った遷移を、イニシャライザ注入のコードに読み替えて説明できる。

## 成果物
- 週末課題「プロフィール画面」（`1108/`）

## 定着確認
- 第3週：デリゲートと `weak`
