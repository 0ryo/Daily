# 課題文の見本（2026-11-10 の課題を、2026-11-11 の短い形で書き直したもの）

管理用の行は省いている。課題を作るときは、この見本の見出しの立て方（「### 種類 `型名`」）、処理の1行の書き方（「**いつ・どの関数**：何をする」）、「確かめること」のチェックリスト（「操作 → 期待する表示」）に合わせる。課題ページ（`.claude/templates/task-page.html`）は、この形を手がかりにカードを組み立てる。

---

# 11/10（火）「読み終えた」を、デリゲートで前の画面に返す

> 詳細画面のスイッチで決めた「読み終えた」を、デリゲートで前の画面に返し、ラベルに出します。

- 作業場所：`1110/`（iOS App・XIB + Auto Layout）
- 想定時間：パート1 1.5時間／パート2 30分
- パート1だけで提出してよいです。

## 守ること
- `!` `try!` `as!` `try?` を使わない（`@IBOutlet` の `!` は除く）
- `book` を書き換えるのは BookViewController だけ。BookDetailViewController は `delegate` で知らせる
- 画面は XIB で作る。Main.storyboard には部品を置かない
- ブランチ `1110` で PR を作る（マージは不要）

## パート1：スイッチの値をデリゲートで返す（1.5時間）

### 構造体 `Book`
読みたい本1冊。今日はファイルに保存しないので、Codable は不要です。

| プロパティ | 型 | 意味 |
|---|---|---|
| `title` | String | 本の題名 |
| `isFinished` | Bool | 読み終えたら `true` |

### プロトコル `BookDetailViewControllerDelegate`
詳細画面が、決めた結果を知らせる相手の決まり。`AnyObject` に準拠させます。

```swift
func bookDetailViewController(_ controller: BookDetailViewController, didSave isFinished: Bool)
```
- 目的：「保存」で決めた値を、`delegate` の相手に知らせる
- 引数：`controller` は知らせる側の画面、`isFinished` は読み終えたかどうか
- 戻り値：なし
- 処理はプロトコルに書かず、BookViewController の extension に書く

### 画面 `BookViewController`
最初の画面。1冊の本の状態をラベルに出します。

- プロパティ：`book`（Book。初期値は「坊っちゃん」、`isFinished` は `false`）
- 部品：状態のラベル、「詳細へ」ボタン

1. **起動したとき**：SceneDelegate で、BookViewController を最初の画面にした UINavigationController を window に入れる
2. **`viewDidLoad()`**：`title` を「本棚」にし、`updateLabel()` を呼ぶ
3. **`updateLabel()`**：ラベルを「坊っちゃん：読み終えた」か「坊っちゃん：まだ読んでいない」にする。題名は `book.title` を使う
4. **「詳細へ」を押したとき**：XIB 名を指定して BookDetailViewController を作り、`delegate` に `self` を入れて push する
5. **`bookDetailViewController(_:didSave:)`**：`book.isFinished` を受け取った値にし、`updateLabel()` を呼ぶ

### 画面 `BookDetailViewController`
読み終えたかどうかを決める画面です。

- プロパティ：`delegate`（BookDetailViewControllerDelegate?。`weak var` で宣言する）
- 部品：「読み終えた」のラベル、UISwitch（XIB でオフにしておく）、「保存」ボタン

1. **「保存」を押したとき**：`delegate` に、自分と UISwitch のオン・オフを渡して知らせる
2. 続けて pop で BookViewController に戻る

### 確かめること
上から順に試し、「保存」で戻った画面のスクリーンショットを PR に貼ります。

- [ ] 実行する → 「本棚」と「坊っちゃん：まだ読んでいない」が出る
- [ ] 「詳細へ」→ スイッチをオン → 「保存」 → ラベルが「坊っちゃん：読み終えた」に変わる

## パート2：開いたときにスイッチを合わせる（30分）

### 画面 `BookDetailViewController`
- プロパティを足す：`isFinished`（Bool。初期値は `false`）

1. **`viewDidLoad()`**：UISwitch のオン・オフを `isFinished` に合わせる

### 画面 `BookViewController`
1. **「詳細へ」を押したとき**：push する前に、BookDetailViewController の `isFinished` に `book.isFinished` を入れる

### 確かめること
パート1の続きとして、アプリを止めずに試します。

- [ ] 「詳細へ」 → スイッチがオンになっている → オフにして、「保存」を押さずに戻る → ラベルは「読み終えた」のまま

### 説明問題
2つのクラスのインスタンスがお互いを強く参照し合うと、ほかから参照されなくなっても、2つともメモリから解放されないのはなぜか？

検索キーワード：`swift strong reference cycle delegate weak`

## 参考
- [Protocols](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/protocols/)：「Delegation」と「Class-Only Protocols」の節
- [Automatic Reference Counting](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/automaticreferencecounting/)：`weak` を付ける理由
- [UISwitch](https://developer.apple.com/documentation/uikit/uiswitch)：オン・オフを切り替える部品
- [init(nibName:bundle:)](https://developer.apple.com/documentation/uikit/uiviewcontroller/init(nibname:bundle:))：XIB の画面をコードで作る
- [pushViewController(_:animated:)](https://developer.apple.com/documentation/uikit/uinavigationcontroller/pushviewcontroller(_:animated:))：次の画面を出す
- [popViewController(animated:)](https://developer.apple.com/documentation/uikit/uinavigationcontroller/popviewcontroller(animated:))：前の画面に戻る
