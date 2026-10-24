# 第11週（2026-12-26 土〜2027-01-01 金）：App1 実装2（API通信・RxSwift検索・Firebase）

> この計画が想定する前提：App1 の中核機能（一覧・編集・保存）が動いている。年末年始で時間が減る場合は週の初めに申告する（削る順番は roadmap.md の「遅れたときの調整」を参照）。週25h。

## 目標
- App1 に外部 API の取得（async/await）と、RxSwift による検索・フィルタを組み込む。
- Firebase（Crashlytics と Analytics）を Swift Package Manager で導入し、クラッシュとイベントがコンソールに届くことを確認する。
- 公開リポジトリに秘密情報を入れない運用（`.gitignore`、設定ファイルの扱い）を決める。

## 学習項目
- Firebase：プロジェクト作成、`GoogleService-Info.plist`、`FirebaseApp.configure()`、Crashlytics の dSYM アップロード、Analytics のイベント送信
- 公開リポジトリでの設定ファイルの扱い：リポジトリに入れない場合の手元での配置方法と、CI で生成する方法（第12週）
- RxSwift と async/await の接続（第8週の復習）
- API 失敗時の再試行と、キャッシュ（前回の取得結果を保存して表示する）

## 教材
- Firebase「Add Firebase to your Apple project」https://firebase.google.com/docs/ios/setup
- Firebase「Get started with Firebase Crashlytics」https://firebase.google.com/docs/crashlytics/get-started?platform=ios
- Firebase「Get started with Google Analytics」https://firebase.google.com/docs/analytics/get-started?platform=ios

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | 外部 API の通信層（async/await）とテスト | 6.0 |
| UIKit | API の結果を画面に表示（読み込み中・失敗・再試行） | 4.0 |
| UIKit | 検索・フィルタを RxSwift でバインド | 5.0 |
| 共通 | Firebase の導入（Crashlytics、Analytics）と動作確認 | 5.0 |
| 共通 | 秘密情報の扱いの整理 | 1.0 |
| 共通 | 振り返り | 2.5 |
| 共通 | 定着確認 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | 通信層と Stub を使ったテスト | `apps/App1/` |
| 日 | API の結果の表示と失敗時の再試行 | `apps/App1/` |
| 月 | 検索・フィルタ（RxSwift の `debounce` と `combineLatest`） | `apps/App1/` |
| 火 | 検索の ViewModel のテスト（RxSwift の値をテストで確かめる） | `apps/App1/` |
| 水 | Firebase 導入とテスト用クラッシュの送信 | `apps/App1/` |
| 木 | Analytics のイベント設計（3種類まで）と送信 | `apps/App1/` |
| 金 | 定着確認：コードでの Auto Layout（第4週） | `0101/` |

## 完了条件
- [ ] 機内モードで API を使う画面を開くと失敗表示が出て、通信を戻して再試行すると表示される。
- [ ] 検索欄の入力から一覧が絞り込まれるまでの流れを、ストリーム図で説明できる。
- [ ] テスト用クラッシュが Firebase コンソールの Crashlytics に表示され、スタックトレースのシンボルが読める。
- [ ] `GoogleService-Info.plist` などの設定ファイルについて、リポジトリに入れるか・入れないかの判断と理由を README に書いている。
- [ ] 通信層と検索の ViewModel のテストが通る。

## 成果物
- App1 の通信・検索・Firebase 対応

## 定着確認
- 第4週：コードでの Auto Layout
