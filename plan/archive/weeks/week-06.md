# 第6週（2026-11-21 土〜11-27 金）：UIKitでのMVVMとユニットテスト

> この計画が想定する前提：複数画面・保存・Diffable を自力で書ける。テストは未経験とする。週25h、Xcode 27.x（Swift Testing と XCTest の両方が使える）。

## 目標
- ViewController が肥大化する原因を説明し、表示用の状態と処理を ViewModel に分けられる。
- 依存（保存・時刻など）を protocol で差し替えられる形にして、ViewModel をユニットテストできる。
- Swift Testing（`@Test`、`#expect`）と XCTest（`XCTestCase`、`XCTAssert...`）の両方でテストを書ける。

## 学習項目
- MVC の VC 肥大化（検証・変換・保存・表示がすべて VC にある状態）と MVVM での分け方
- ViewModel から VC への通知：クロージャによる通知（RxSwift は第8週）
- 依存性注入（イニシャライザ注入）と protocol によるテスト用の差し替え（Fake・Stub）
- Swift Testing：`@Test`、`#expect`、`#require`、パラメータ化テスト（`arguments:`）
- XCTest：`XCTestCase`、`setUp`、`XCTAssertEqual`。既存プロジェクトでは XCTest が多いため両方を書く
- テストターゲットの追加、`⌘U`、テストの命名

## 教材
- Develop in Swift「Add functionality with Swift Testing」https://developer.apple.com/tutorials/develop-in-swift/add-functionality-with-swift-testing
- Apple「Swift Testing」https://developer.apple.com/documentation/testing
- Apple「Defining test suites and test cases（XCTest）」https://developer.apple.com/documentation/xctest/defining-test-cases-and-test-methods
- WWDC24「Meet Swift Testing」https://developer.apple.com/videos/play/wwdc2024/10179/

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | 教材（Swift Testing、XCTest、WWDC動画） | 4.5 |
| UIKit | 週末課題「肥大化した VC を MVVM に分ける」 | 7.0 |
| 共通 | 毎日の課題（テストを書く） | 6.0 |
| UIKit | 毎日の課題（ViewModel と VC の接続） | 3.5 |
| 共通 | 定着確認 | 1.5 |
| 共通 | 振り返りと記録 | 2.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 第3週の「連絡先メモ」をコピーし、VC から検証・保存・表示用文字列の生成を ViewModel へ移す | `1121/` |
| 日 | 土曜の続き。保存を protocol で抽象化し、テスト用の保存先に差し替えられるようにする | `1121/` |
| 月 | 1121 の ViewModel に Swift Testing で正常系・異常系・境界値のテストを書く | `1121/` |
| 火 | 同じテストの一部を XCTest で書き、2つの書き方の違いを PR にまとめる | `1121/` |
| 水 | パラメータ化テストで、入力検証の表（10件以上）を1つのテスト関数で確かめる | `1125/` |
| 木 | 現在日時に依存する処理（期限切れ判定）を、日時を注入してテストする | `1126/` |
| 金 | 定着確認：Diffable Data Source（第5週） | `1127/` |

## 完了条件
- [ ] 1121 の ViewController に、検証・保存・文字列整形のコードが残っていない（VC は入力の受け渡しと表示だけ）。
- [ ] ViewModel のテストが10件以上あり、`⌘U` ですべて通る。異常系と境界値を含む。
- [ ] テストがファイル保存を実際に行わずに動く（protocol で差し替えている）。
- [ ] `#expect` と `#require` の違いを説明できる。

## 成果物
- MVVM 化とテストを含む `1121/`（テストターゲット付き）

## 定着確認
- 第5週：Snapshot による追加・削除
