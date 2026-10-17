# 第1週（2026-10-17 土〜10-23 金）：入力検証の仕上げとPRによる作業の流れ

> この計画が想定する前提：UIKit（XIB）で1画面・一覧・入力検証を自力で実装できる段階から始める。週25h（土日6.5h、平日2.5h）で、Xcode 27.x／Swift 6.4／iOS 27 SDKを使う。

## 目標
- 単元4前半（入力と検証）を終える。UITextFieldDelegateとreturnキーを使い、入力中の検証を自分で実装できる。
- UIViewControllerのライフサイクルで、各メソッドが呼ばれる順番を実機で確認して説明できる。
- このリポジトリで「ブランチを作る → コミット → PR → セルフレビュー → マージ」の流れを毎日回せる。

## 学習項目
- UITextFieldDelegate（`textFieldShouldReturn`、`shouldChangeCharactersIn`）、`.editingChanged` の target-action、`isEnabled` による送信ボタンの制御
- UISwitch・UIStepper・UISegmentedControl の値の取得と、モデルへの反映
- ライフサイクル：`viewDidLoad`、`viewWillAppear`、`viewDidAppear`、`viewWillDisappear`、`viewDidDisappear`、`viewDidLayoutSubviews`
- キーボード：`view.keyboardLayoutGuide` で入力欄をキーボードに隠れない位置に保つ
- Git：ブランチ名の規則（例：`daily/1017`）、コミットの粒度、PRの説明文、`git diff` によるセルフレビュー

## 教材
- Apple「UITextFieldDelegate」https://developer.apple.com/documentation/uikit/uitextfielddelegate
- Apple「UIViewController」の「Managing the view」https://developer.apple.com/documentation/uikit/uiviewcontroller
- Apple「Adjusting your layout with keyboard layout guide」https://developer.apple.com/documentation/uikit/adjusting-your-layout-with-keyboard-layout-guide
- GitHub Docs「About pull requests」https://docs.github.com/pull-requests

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| UIKit | 教材を読み、小さく試す（Delegate、ライフサイクル、キーボード） | 4.0 |
| UIKit | 毎日の課題の実装（平日5日分） | 8.5 |
| UIKit | 週末課題「会員登録フォーム」の実装 | 5.5 |
| 共通 | Git・PR作法の学習。未コミットの1013〜1016をPRで整理する | 3.5 |
| 共通 | 定着確認（過去範囲から1問） | 1.5 |
| 共通 | 振り返りと記録 | 2.0 |

## 課題（詳細な仕様は毎日の出題で示す）
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | Git作法の準備：1013〜1016を課題ごとのブランチでコミットし、PRを作ってマージする。PRテンプレートを自分で書く | リポジトリ直下 |
| 日 | 週末課題「会員登録フォーム」：名前・年齢（UIStepper）・通知可否（UISwitch）を入力し、入力中に検証して登録ボタンの有効・無効を切り替える | `1018/` |
| 月 | returnキーで次の入力欄へ移り、最後の欄で送信する | `1019/` |
| 火 | `shouldChangeCharactersIn` で、数字以外の入力と4桁を超える入力を拒否する | `1020/` |
| 水 | ライフサイクル観察：画面を表示・非表示にして、呼ばれたメソッドを順にラベルとログに出す | `1021/` |
| 木 | `keyboardLayoutGuide` を使い、キーボードを出しても入力欄と送信ボタンが隠れない画面を作る | `1022/` |
| 金 | 定着確認：struct と enum の状態遷移（0927の題材とは別の題材） | `1023/` |

## 完了条件（自分で確認できる形）
- [ ] 送信ボタンの有効・無効が、入力のたびに正しく切り替わる。空欄、空白だけの入力、範囲外の値のときは押せない。
- [ ] `textFieldShouldReturn` と `.editingChanged` の役割の違いを、何も見ずに2文で説明できる。
- [ ] 画面Aから画面Bへ移って戻るときのライフサイクルメソッドの順番を、予想してから実行し、予想と一致させられる。
- [ ] 今週の課題がすべてPR経由で `main` に入っている。どのPRにも「目的・変更点・確認したこと」が書いてある。
- [ ] 定着確認の課題を、過去のコードを見ずに書ける。

## 成果物
- 毎日の課題（`MMDD/`）
- PRテンプレート（`.github/pull_request_template.md`。作成前に先生役の承認を得る）

## 定着確認
- struct の mutating と enum の関連値（0924〜0928の範囲）
