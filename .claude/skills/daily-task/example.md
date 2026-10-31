# 課題文の見本（2026-10-28 の課題を新しい形式で書き直したもの）

管理用の行は省いている。課題を作るときは、この見本の書き方（順番、番号、改行、ドキュメントの添え書き）に合わせる。

この見本はパートに分ける前の形式である。全体の並び（守ること → パート1 → パート2、各パートの中に構造体・画面・テスト）は SKILL.md の書式と、パートに分けた見本の `tasks/2026-10-31.md` に合わせる。この見本では、関数の書き方と表の改行を参考にする。

---

# 10/28（水）植物の水やり表を、実際のファイルに読み書きする
- 作業場所：`1028.playground`
- 想定時間：2時間

## 要件
### 構造体
**1. Plant**
- プロパティ：`name`（String、植物の名前）、`intervalDays`（Int、何日おきに水をやるか）
- 関数：なし
- 特記事項：エンコードとデコードができる。CodingKeys は不要。

**2. PlantStorage**（植物の一覧をファイルに保存し、読み込む構造体）
- プロパティ：`fileURL`（URL、保存先のファイル。Documents ディレクトリの中の `plants.json`）
- 関数：
  - **2-1. `save(_ plants: [Plant]) throws`**
    - 処理：植物の配列を受け取り、JSON にエンコードして、`fileURL` のファイルに書き込む。
    - 書き込み時は `.atomic` を指定する。
    - エンコードや書き込みに失敗したら、エラーを呼び出し元に投げる。
  - **2-2. `load() throws -> [Plant]`**
    - 処理：`fileURL` のファイルを読み込み、植物の配列にデコードして返す。
    - 読み込みやデコードに失敗したら、エラーを呼び出し元に投げる。

### 並べ替え問題
テスト2で、前回の実行で残った `plants.json` を消すための関数です。
下の行を正しい順に並べ、インデントを整えて Playground に置いてください。行の追加と削除はしません。

```swift
        print("削除に失敗しました: \(error)")
    do {
func deleteFileIfExists(at url: URL) {
        return
    }
        try FileManager.default.removeItem(at: url)
}
        print("削除するファイルはありません")
    } catch {
    guard FileManager.default.fileExists(atPath: url.path) else {
        print("ファイルを削除しました")
    }
```

### 守ること
- `!`、`try!`、`as!`、`try?` を使わない。
- 型名は大文字、変数名・関数名・プロパティ名は小文字で始める。
- 結果やエラーの print は、テストを書く側（`do`/`catch` の中）で行う。
- ブランチを切り、今日の Playground の変更だけで PR を作る（マージは不要）。

### テスト
上から順に実行します。すべてのテストで、同じ PlantStorage を使います。

| 番号 | すること | 期待する結果 |
|---|---|---|
| 1 | `fileURL` を print する。 | Documents ディレクトリの中の `plants.json` の場所が表示される。 |
| 2 | 並べ替え問題の関数で `plants.json` を消す。<br>そのあと 2-2 で読み込む。 | 削除できた、またはファイルがない、というメッセージが表示される。<br>読み込みは失敗し、エラーの内容が表示される。<br>クラッシュしない。 |
| 3 | 次の3件を 2-1 で保存する。<br>モンステラ（7日）、サボテン（14日）、バジル（2日） | 「保存しました」と表示される。 |
| 4 | 2-2 で読み込む。 | 件数 3 と表示される。<br>3件の名前と日数が、テスト3と同じ順で表示される。 |
| 5 | ポトス（5日）の1件だけを 2-1 で保存する。<br>そのあと 2-2 で読み込む。 | 件数 1 と表示され、ポトスだけが表示される。<br>テスト3で保存した3件は含まれない。 |
| 6 | 空の配列を 2-1 で保存する。<br>そのあと 2-2 で読み込む。 | 失敗せず、件数 0 と表示される。 |

## 説明問題
1. 書き込み時に `.atomic` を指定すると、書き込みの途中でアプリが止まっても、元のファイルが壊れないのはなぜか？［検索キーワード：swift Data write atomic］
2. テスト5で読み込んだ結果に、テスト3で保存したデータが含まれないのはなぜか？［検索キーワード：swift Data write(to:options:)］

答えはチャットで1〜2文ずつ書いてください。

## 参考
### 公式ドキュメント
- [URL.documentsDirectory](https://developer.apple.com/documentation/foundation/url/documentsdirectory)：Documents ディレクトリの場所を取り出す方法（1 の `fileURL`）。
- [JSONEncoder](https://developer.apple.com/documentation/foundation/jsonencoder)／[JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)：配列を JSON の Data にする方法と、元に戻す方法（2-1、2-2）。
- [Data.write(to:options:)](https://developer.apple.com/documentation/foundation/data/write(to:options:))：Data をファイルに書き込む方法（2-1、説明問題2）。
- [NSData.WritingOptions.atomic](https://developer.apple.com/documentation/foundation/nsdata/writingoptions/atomic)：`.atomic` を指定すると何が起きるか（説明問題1）。
- [Data.init(contentsOf:options:)](https://developer.apple.com/documentation/foundation/data/init(contentsof:options:))：ファイルを Data として読み込む方法（2-2）。
- [Error Handling（The Swift Programming Language）](https://docs.swift.org/swift-book/documentation/the-swift-programming-language/errorhandling/)の「Propagating Errors Using Throwing Functions」：エラーを呼び出し元に投げる書き方（2-1、2-2）。
