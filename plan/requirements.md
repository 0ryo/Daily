# 求人要件と成果物の対応表

> この計画が想定する前提：2026-10-17に、国内の iOS エンジニア求人4件（UIKit を必須とする求人を含む）から要件を抽出した。実務年数とマネジメント経験は対象外とする。求人の内容は掲載時点のもので、変わる可能性がある。

## 調べた求人

| # | 企業・職種 | 年収（掲載時点） | 要件の要点 | 出典 |
|---|---|---|---|---|
| A | 株式会社AppBrew（LIPS）iOSエンジニア | 700万〜1,200万円 | 技術スタック：Swift、UIKit、SwiftUI、RxSwift、GitHub Actions、CircleCI、fastlane。必須・歓迎はログインが必要で未確認 | https://findy-code.io/companies/706/jobs/ikQ7R57I9tkZQ |
| B | 株式会社U-NEXT Software Engineer - iOS | ページから取得できず（検索結果の要約では600万〜1,200万円） | 必須：Swift の習熟、**UIKit の十分な理解**、git、Instruments によるメモリと性能の調整、チーム開発。歓迎：MVVM、REST／GraphQL、XCTest（ユニット・UI）、Combine、SwiftUI、Swift Concurrency、Firebase Cloud Messaging、Core Data、HIG。AI を使った開発の経験も必須 | https://hrmos.co/pages/unext/jobs/9159313 |
| C | 株式会社Cygames iOSエンジニア（東京） | 年収例：28歳600万円、31歳650万円、39歳800万円 | 必須：SwiftUI または UIKit で OS の特性を生かした UI、メモリ不足や性能の問題の調査・解決、**正常系・異常系を考慮したサーバー通信**、適切なフレームワークの選択。歓迎：App Store へのリリース経験、MVVM・Clean Architecture。環境：GitHub Actions、Swift Package Manager、Firebase | https://hrmos.co/pages/cygames/jobs/0000029 |
| D | スタキャリテック掲載（企業名非公開）iOSエンジニア（業務委託） | 非公開 | 必須：Swift でのアプリ開発、リアクティブプログラミング、宣言的 UI（SwiftUI）、MVC 以外のアーキテクチャ。環境：The Composable Architecture、RxSwift、Alamofire、Firebase、Fastlane、GitHub Actions | https://www.stand.tech/stacareetech/jobs/21426 |

補足：検索結果の要約では、STORES 株式会社の求人が SwiftUI の開発経験とユニットテストの実装経験を必須としていた（https://scouting.mynavi.jp/job-detail/41595968/ 。2026-10-17時点で掲載終了のため本文は未確認）。

## 要件と成果物の対応

「出現」は上の求人のどれに出てくるか（必＝必須、歓＝歓迎、環＝開発環境として記載、指＝学習者が指定した要件）。「証拠」の列は、達成したときに学習者がリンクを書き込む。

| # | 要件 | 出現 | 示す週 | 示す成果物 | 達成の判定 | 証拠 |
|---|---|---|---|---|---|---|
| 1 | Swift の習熟 | A環 B必 C必 D必 | 全週 | 毎日の課題、App1、App2 | AIなし課題 CP1〜CP6 で「Swiftらしさ」がレベル3以上 | |
| 2 | UIKit（ライフサイクル、Auto Layout、一覧、遷移、デリゲート、メモリ管理） | A環 B必 C必 指 | 1〜5、10〜14、23 | App1、CP4、大規模コードの読解記録 | App1 公開。CP4 が70点以上。読解記録で1機能を図にしている | |
| 3 | Auto Layout（コードと Storyboard／XIB の読解） | B必 C必 指 | 4 | 第4週の課題、App1 | 文字サイズ最大・縦横で制約衝突のログ0件 | |
| 4 | UITableView／UICollectionView（Diffable、Compositional Layout） | 指 | 5、10 | App1 の一覧 | `reloadData` を使わずにスナップショットで更新している | |
| 5 | SwiftUI（@State、@Binding、@Observable、NavigationStack、List） | A環 B歓 C必 D必 指 | 15〜22 | App2、CP5 | App2 を TestFlight で配信。CP5 が70点以上 | |
| 6 | SwiftData | 指 | 19、21 | App2 のお気に入り | 再起動後・オフラインでも表示される | |
| 7 | UIKit と SwiftUI の相互運用 | 指（B・C は両方を扱う） | 17、18、20 | App1 1.1（UIHostingController、UIHostingConfiguration）、App2（Representable） | App1 1.1 を提出し、技術記事2で段階導入を説明している | |
| 8 | MVVM などのアーキテクチャ（MVC 以外） | B歓 C歓 D必 指 | 6、9 | App1、App2 | VC／View に検証・保存・通信の処理がない。設計図が README にある | |
| 9 | リアクティブプログラミング（RxSwift、Combine） | A環 B歓 D必 | 8、11 | 第8週の3通りの検索画面、App1 の検索 | App1 の検索が RxSwift で動き、ViewModel のテストがある | |
| 10 | Swift Concurrency | B歓 指 | 7、11、20、21 | App1 と App2 の通信層 | Swift 6 言語モードで警告0。キャンセルを扱っている | |
| 11 | API 通信（正常系・異常系） | B歓 C必 指 | 7、11、20 | App1、App2 | 機内モード・0件・エラー応答でそれぞれの表示がある | |
| 12 | テスト（XCTest／Swift Testing） | B歓 指（STORES 必） | 6、21 | App1・App2 のテスト | App2 のテスト15件以上が CI で通る。XCTest の例も残っている | |
| 13 | CI/CD（GitHub Actions、Fastlane） | A環 C環 D環 指 | 12、21 | `.github/workflows/`、`fastlane/` | PR ごとに CI が動き、`fastlane beta` で TestFlight に上がる | |
| 14 | Firebase | B歓 C環 D環 指 | 11、22 | App1（Crashlytics、Analytics）、App2（任意で Remote Config） | Crashlytics にテスト用クラッシュが届いている | |
| 15 | App Store リリース | C歓 指 | 12〜14、18 | App1 の App Store ページ | 第14週までに公開 | |
| 16 | メモリと性能の調査（Instruments） | B必 C必 | 3、13 | App1 の PR（Instruments の結果と修正） | 主要な操作を繰り返してもリークが出ない記録がある | |
| 17 | Swift Package Manager | C環 | 9、11 | App1 のローカルパッケージ、Firebase の導入 | パッケージ単体のテストが通る | |
| 18 | Git でのチーム開発の作法 | B必 C環 指 | 1〜24 | このリポジトリの PR 履歴、OSS への PR | 全変更が PR 経由。PR に目的・変更点・確認内容がある | |
| 19 | OSS 貢献 | 指 | 7、19、23 | OSS への PR 2件以上 | 2件以上を提出（マージは問わないが、1件以上のマージを目指す） | |
| 20 | 技術発信 | 指 | 14、18、22 | 技術記事3本、LT 1回 | 3本公開 | |
| 21 | アクセシビリティ・HIG | B歓 | 13、22 | App1、App2 | VoiceOver だけで主要な操作ができる | |

## 対象外とした要件

| 要件 | 出現 | 理由 |
|---|---|---|
| 実務年数、チーム開発の年数、マネジメント | A〜D | 最終目標の定義で除外 |
| Objective-C | B・C | 大規模コードの読解（第23週）で読める程度に触れるが、書く練習はしない |
| The Composable Architecture | D | 1求人のみ。MVVM を優先し、入社先で必要になったら学ぶ |
| GraphQL、AVFoundation、StoreKit、EPUB など | B | 特定の事業領域の技術のため |
| Kotlin Multiplatform、Unity、Android | C | iOS に絞る方針のため |
| AI を使った開発の作法 | B必 C歓 | この計画では AI を先生役に限定する。入社前後に、AI の提案を自分で検証して採否を決める練習を別途行う |
