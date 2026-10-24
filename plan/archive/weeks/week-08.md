# 第8週（2026-12-05 土〜12-11 金）：RxSwiftとCombine（入社先の既存コードを読む準備）

> この計画が想定する前提：async/await と MVVM を書ける。7月に RxSwift のコードを AI が書いたが、本人による実装は未経験とする。入社先は RxSwift と Combine を使う。週25h。

## 目標
- RxSwift で ViewModel の入力と出力を定義し、UIKit の部品にバインドできる。
- `DisposeBag` とクロージャ内の `[weak self]` で、購読による循環参照を防げる。
- Combine の `@Published`・`sink`・`AnyCancellable` を読んで動作を説明できる。
- RxSwift・Combine と async/await の対応関係（どれをどれに置き換えられるか）を表にまとめられる。
- Apple Developer Program に登録する（第13週の審査提出に必要）。

## 学習項目
- RxSwift：`Observable`、`PublishRelay`／`BehaviorRelay`、`Driver`、`bind(to:)`、`map`・`filter`・`debounce`・`flatMapLatest`、`DisposeBag`
- RxCocoa：`rx.text`、`rx.tap`、`rx.isEnabled`
- Combine：`Publisher`、`@Published`、`sink`、`assign`、`AnyCancellable`、`debounce`
- 相互変換：Combine の `values`（AsyncSequence）、RxSwift の `values`、`Task` から Relay への値の送り方
- 既存コードの読み方：入力から出力までのストリームを図に描く

## 教材
- RxSwift リポジトリの Documentation（Getting Started）https://github.com/ReactiveX/RxSwift/tree/main/Documentation
- Apple「Combine」https://developer.apple.com/documentation/combine
- 7月に AI が書いた `swift_practice/TaskFromJSON` と `APIKitTest`（読解の題材としてのみ使う）
- Apple Developer Program（登録）https://developer.apple.com/programs/

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | 教材（RxSwift、Combine） | 5.0 |
| UIKit | 毎日の課題（Rx と UIKit のバインド） | 7.0 |
| 共通 | 週末課題「TaskFromJSON の読解と、自分での再実装」 | 6.5 |
| 共通 | Combine と async/await への書き換え課題 | 2.0 |
| 共通 | Apple Developer Program の登録手続き | 1.0 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 2.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | `TaskFromJSON` の ViewModel を読み、入力から出力までのストリーム図を描く。図だけを見て、同じ機能を別題材で自分で書く | `1205/` |
| 日 | 土曜の続き。Apple Developer Program に登録する（個人登録では本名が販売者名として表示される点を確認してから） | `1205/` |
| 月 | 検索欄の入力を `debounce` して API 検索し、結果を一覧にバインドする（RxSwift） | `1207/` |
| 火 | 購読で循環参照を起こし、`deinit` が呼ばれないことを確かめてから直す | `1208/` |
| 水 | 月曜の課題を Combine で書き直す | `1209/` |
| 木 | 月曜の課題の通信部分を async/await にし、RxSwift とつなぐ | `1210/` |
| 金 | 定着確認：async/await と状態表示（第7週） | `1211/` |

## 完了条件
- [ ] 検索欄に素早く入力しても、最後の入力に対する通信だけが行われる（`debounce` と `flatMapLatest` の効果をログで確認する）。
- [ ] 画面を閉じると ViewModel と VC の `deinit` が呼ばれる。
- [ ] `Driver` を使う理由（メインスレッド、エラーで止まらない）を説明できる。
- [ ] RxSwift・Combine・async/await の対応表（値を1回返す、何度も流す、キャンセル）を自分で作れる。
- [ ] Apple Developer Program の登録が完了している、または手続き中で完了予定日がわかっている。

## 成果物
- RxSwift・Combine・async/await の3通りで実装した検索画面（`1207/`〜`1210/`）
- 3つの書き方の対応表（PR の説明文に残す）

## 定着確認
- 第7週：async/await と Task のキャンセル
