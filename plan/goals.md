# 学習の目標（長期・中期・短期）

2026-10-24 に学習者と決めた運用。2026-10-17 に作った24週の詳細計画は、先の週まで固定していたため進度に合わせて直しにくく、[archive/](archive/) に移した（**今後は参照しない**）。

| 種類 | 期間 | 置き場所 | 見直し |
|---|---|---|---|
| 長期 | 最終目標（〜2027-03-31） | このファイル | 学習者が決めたときだけ |
| 中期 | 月ごと（月末に達成していたい状態） | このファイル | 学習者が承認したときだけ |
| 短期 | 週ごと（土曜始まり） | `plan/short-term/week-XX.md` | **毎週末に、その週の進度を見て来週の分を作る**（/week） |

- 短期目標は1週間分だけ作る。2週間以上先の週ファイルは作らない。
- 「ここをもう少し学びたい」となったら、来週の短期目標で調整する。中期目標がずれそうなときは、/week で見通しを伝え、中期目標を直すかどうかを学習者に聞く。
- 週番号は第1週＝2026-10-17（土）からの通し番号を使う。

## 長期目標（2027-03-31 まで）
年収700万円帯の iOS エンジニア求人が求める技術要件のうち、実務年数とマネジメント経験を除くすべてを、成果物（公開アプリ・リポジトリ・記事・PR）で示せる状態にする。要件と証拠の対応は [requirements.md](requirements.md) で管理する（requirements.md の「示す週」の列は旧計画の週で、目安として残している）。

- 主な成果物：App1（UIKit 主体、App Store で公開）、App2（SwiftUI 主体、TestFlight で配信）、技術記事3本、OSS への PR 2件、毎日の課題と PR。
- 学習時間の配分の目安（全期間）：UIKit 30%、SwiftUI 17%、相互運用 5%、共通 47%。累計が目安から20%以上ずれたら /week で指摘する。
- 毎日の学習時間の基準：平日2.5h、土日6.5h（週25h）。
- 月1回の AIなし課題（CP）と人間レビュー（HR）の決まりは [checkpoints.md](checkpoints.md)、採点は [rubric.md](rubric.md) に従う。

## 中期目標（月ごと）
旧計画で各月末までに終える予定だった内容。

### 10月（〜10/31）：UIKit の入力と保存（単元4）
- UITextFieldDelegate と return キーを使い、入力中の検証を自分で実装できる。
- UIViewController のライフサイクルで、各メソッドが呼ばれる順番を確かめて説明できる。
- 入力したデータを Codable とファイルで保存し、再起動後に同じ順番で復元できる。
- 保存・読み込みに失敗したときの処理を、`throws` と `do`/`catch` で書き分けて説明できる。保存処理を ViewController ではなく保存用の型に置ける。
- 「ブランチ → コミット → PR → セルフレビュー → マージ」の流れを毎日回せる。
- CP1（UIKit の1画面・入力検証・一覧、90分）を解く。HR1（勉強会で自分のコードに1件以上コメントをもらう）。

### 11月（〜11/30）：UIKit の基盤と設計・テスト
- UINavigationController で一覧 → 詳細 → 編集を作り、デリゲート（protocol と weak 参照）とクロージャで結果を返せる。循環参照を Memory Graph Debugger と `deinit` で確かめられる。
- XIB を使わずコードで Auto Layout を組み、制約の衝突のログを読んで直せる。Storyboard の既存画面を読める。`keyboardLayoutGuide` で入力欄を隠さない。
- UICollectionView を Diffable Data Source と Compositional Layout で組める。
- 表示用の状態と処理を ViewModel に分け、依存を protocol で差し替えてユニットテストできる（Swift Testing と XCTest）。
- CP2（画面遷移・デリゲート・Codable 保存、120分）を解く。
- 10月からの持ち越し（2026-10-31 に学習者が承認）：UIKit のアプリで保存したデータを再起動後に同じ順番で復元する。UIViewController のライフサイクルのメソッドが呼ばれる順番を確かめて説明できる。return キーで次の入力欄へ移る。HR1（勉強会で自分のコードに1件以上コメントをもらう）。11月が詰まるため、UICollectionView を12月に回すかを11月の途中の /week で決める。

### 12月（〜12/31）：非同期・リアクティブと App1 の実装
- `async`/`await` と `URLSession` で API の JSON を取得し、読み込み中・成功・空・失敗・再試行を ViewModel で表せる。`@MainActor` の理由を説明できる。
- RxSwift で ViewModel の入力と出力をバインドし、Combine の基本を読める。async/await との対応を説明できる。
- Apple Developer Program に登録する。HR2（OSS への最初の PR）。
- App1（UIKit 主体）の要件・設計を決め（HR3：設計レビュー）、一覧・詳細・編集・保存・API 通信・RxSwift の検索・Firebase を実装する。
- CP3（MVVM・async/await・ユニットテスト、150分）を解く。

### 1月（〜1/31）：App1 の公開と SwiftUI 入門
- GitHub Actions と Fastlane で CI/CD を整え、App1 を TestFlight で配信する。
- Instruments・アクセシビリティを点検し、審査に提出して、**App1 を App Store で公開する**。技術記事1を公開する。HR4（3人以上に使ってもらう）。
- SwiftUI の View・レイアウト・`@State` を使い、簡単な画面を教材を見ずに組める。
- CP4（UIKit の総合、XIB なし、150分）を解く。

### 2月（〜2/28）：SwiftUI と相互運用、App2 の設計
- `@Binding`・`List`・`Form`・`NavigationStack`・`@Observable` で、一覧・追加・編集を作れる。
- App1 に UIHostingController と UIHostingConfiguration で SwiftUI の画面を段階的に加え、バージョン 1.1 を提出する。技術記事2を公開する。
- SwiftData で保存・取得し、App2（SwiftUI 主体）の要件と設計を決める。HR5（OSS への2件目の PR）。
- CP5（SwiftUI の基礎、150分）を解く。

### 3月（〜3/31）：App2 と総仕上げ
- App2 を実装し（検索・一覧・詳細・お気に入りの SwiftData 保存・Representable・テスト・CI）、TestFlight で配信する。技術記事3を公開する。
- 大規模な公開 UIKit アプリを読み、1つの機能の処理を図にできる。HR6（LT または成果物の共有）。
- CP6（総合、180分）を解く。requirements.md の全行に証拠を記入し、最終目標を判定する。

## 短期目標（週ごと）
- 今週：[short-term/week-03.md](short-term/week-03.md)
- 書き方：`plan/short-term/` の既存の週ファイルと同じ形（目標・課題表・完了条件・持ち越し）にする。/week が週末に、その週の判定のあと来週の分の案を出し、学習者の承認を得て保存する。
