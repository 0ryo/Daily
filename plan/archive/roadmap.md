# 24週ロードマップ（2026-10-17〜2027-03-31）

> この計画が想定する前提：2026-10-17時点で、UIKit（XIB）による1画面・一覧・入力検証を自力で実装でき、SwiftUI は初歩から学ぶ。週25h（土日6.5h、平日2.5h）で、Xcode 27.x／Swift 6.4／iOS 27 SDK（2026-10時点の最新版）を使う。

## 最終目標
年収700万円帯の iOS エンジニア求人が求める技術要件のうち、実務年数とマネジメント経験を除くすべてを、成果物（公開アプリ・リポジトリ・記事・PR）で示せる状態にする。要件と証拠の対応は [requirements.md](requirements.md) で管理する。

## 進め方の決まり
- Claude Code は先生役として、出題・進度管理・評価だけを行う。コードはすべて学習者が書く。
- 平日は1日1課題（2.5h）。週末は大きめの課題、またはアプリ制作（6.5h×2）。
- 課題は `MMDD/`（日付）に置く。成果物アプリは `apps/App1/`・`apps/App2/` に置く（`apps/` の作成前に承認を得る）。
- 毎週金曜は、過去の範囲から定着確認を1問出す。
- すべての変更はブランチと PR で `main` に入れる（第1週から）。
- 採点は [rubric.md](rubric.md)、月1回のAIなし課題と人間レビューは [checkpoints.md](checkpoints.md) に従う。

## フェーズ

| フェーズ | 週 | 期間 | 目的 | 完了条件 | 主な成果物 |
|---|---|---|---|---|---|
| 1. UIKit の基盤 | 1〜5 | 10/17〜11/20 | 入力・保存・画面遷移・Auto Layout・UICollectionView を、既存コードを読んで改修できる水準にする | CP1・CP2 が70点以上。デリゲート・`weak`・Diffable を見ずに書ける | 毎日の課題、単元4の統合課題、連絡先メモ |
| 2. 設計・テスト・非同期 | 6〜8 | 11/21〜12/11 | MVVM、ユニットテスト、Swift Concurrency、入社先で使う RxSwift・Combine | ViewModel のテストが通る。Swift 6 言語モードで警告0。3通りの非同期の書き方を説明できる | 祝日一覧アプリ、3通りの検索画面、OSS への PR（1件目） |
| 3. UIKit アプリの制作と公開 | 9〜14 | 12/12〜1/22 | App1（UIKit 主体）を設計・実装し、CI/CD を整え、**第14週までに App Store で公開する** | App1 が公開されている。CI が PR ごとに動く。技術記事1が公開されている | App1、CI/CD、技術記事1 |
| 4. SwiftUI の基礎と相互運用 | 15〜18 | 1/23〜2/19 | SwiftUI を初歩から学び、App1 に SwiftUI の画面を段階的に追加する | CP4・CP5 が70点以上。App1 1.1（UIKit と SwiftUI の混在）を提出。技術記事2が公開されている | SwiftUI の基礎課題、App1 1.1、技術記事2 |
| 5. SwiftUI アプリと総仕上げ | 19〜24 | 2/20〜3/31 | App2（SwiftUI 主体、SwiftData・API・UIKit 部品の利用）を作り、大規模 UIKit コードの読解と最終判定を行う | App2 が TestFlight で配信されている。CP6 が75点以上。requirements.md の全行に証拠がある | App2、技術記事3、OSS への PR（2件目）、LT |

## マイルストーン

| 週 | 日付 | マイルストーン |
|---|---|---|
| 2 | 10/25 | CP1（AIなし、90分） |
| 5 | 11/15 | CP2（AIなし、120分） |
| 7 | 12/3 | OSS への PR（1件目）を提出 |
| 8 | 12/6 | Apple Developer Program の登録を完了（審査提出に必要） |
| 9 | 12/12 | CP3（AIなし、150分）。App1 の設計完了 |
| 12 | 1/8 | CI/CD 完成。App1 を TestFlight で配信 |
| 13 | 1/14 | App1 を審査に提出 |
| **14** | **1/22** | **App1 を App Store で公開（最終期限）**。技術記事1 |
| 15 | 1/23 | CP4（AIなし、150分） |
| 18 | 2/13〜2/17 | CP5（AIなし、150分）。App1 1.1（SwiftUI 段階導入）提出。技術記事2 |
| 19 | 2/24 | OSS への PR（2件目、コードの変更を含む） |
| 22 | 3/19 | App2 を TestFlight で配信。技術記事3 |
| 23 | 3/20 | CP6（AIなし、180分）。LT または成果物の共有 |
| 24 | 3/31 | 最終判定 |

## UIKit と SwiftUI の配分

週ファイルの時間配分を集計した値（合計595.5h）。「共通」は Swift・設計・テスト・通信・CI/CD・リリース・記事など、フレームワークによらない作業。ただし第9〜14週の「共通」の大半は App1（UIKit アプリ）の上で行う。

| 区分 | 時間 | 割合 |
|---|---:|---:|
| UIKit | 179.0h | 30% |
| SwiftUI | 102.5h | 17% |
| 相互運用（UIHostingController、UIHostingConfiguration、Representable） | 31.5h | 5% |
| 共通 | 282.5h | 47% |

| 週 | UIKit | SwiftUI | 相互運用 | 共通 | 主題 |
|---|---:|---:|---:|---:|---|
| 1 | 18.0 | 0 | 0 | 7.0 | 入力検証、ライフサイクル、PR の流れ |
| 2 | 8.0 | 0 | 0 | 17.0 | Codable 保存、エラー処理、CP1 |
| 3 | 21.0 | 0 | 0 | 4.0 | 画面遷移、デリゲート、メモリ管理 |
| 4 | 21.5 | 0 | 0 | 3.5 | コードでの Auto Layout、Storyboard の読解 |
| 5 | 18.0 | 0 | 0 | 7.0 | Diffable、Compositional Layout、CP2 |
| 6 | 10.5 | 0 | 0 | 14.5 | MVVM、XCTest／Swift Testing |
| 7 | 5.0 | 0 | 0 | 20.0 | Swift Concurrency、URLSession |
| 8 | 7.0 | 0 | 0 | 18.0 | RxSwift、Combine |
| 9 | 6.0 | 0 | 0 | 19.0 | App1 の設計、SPM、CP3 |
| 10 | 16.0 | 0 | 0 | 9.0 | App1 実装1 |
| 11 | 9.0 | 0 | 0 | 16.0 | App1 実装2、Firebase |
| 12 | 0 | 0 | 0 | 25.0 | GitHub Actions、Fastlane、TestFlight |
| 13 | 11.0 | 0 | 0 | 14.0 | Instruments、アクセシビリティ、審査提出 |
| 14 | 8.0 | 0 | 0 | 17.0 | App1 公開、技術記事1 |
| 15 | 3.0 | 18.5 | 0 | 3.5 | SwiftUI 入門1、CP4 |
| 16 | 0 | 21.5 | 0 | 3.5 | SwiftUI 入門2 |
| 17 | 0 | 11.0 | 10.0 | 4.0 | @Observable、App1 段階導入1 |
| 18 | 0 | 4.0 | 12.5 | 8.5 | App1 段階導入2、技術記事2、CP5 |
| 19 | 0 | 14.5 | 0 | 10.5 | SwiftData、App2 の設計 |
| 20 | 0 | 12.5 | 5.5 | 7.0 | App2 実装1、Representable |
| 21 | 0 | 8.5 | 2.0 | 14.5 | App2 実装2、テスト、CI |
| 22 | 0 | 6.5 | 0 | 18.5 | App2 配信、技術記事3 |
| 23 | 13.0 | 1.5 | 1.5 | 9.0 | 大規模 UIKit コードの読解、CP6 |
| 24 | 4.0 | 4.0 | 0 | 12.5 | 総仕上げ（20.5h） |

## 成果物の一覧

| 成果物 | 形式 | 週 | 示す要件 |
|---|---|---|---|
| App1（UIKit 主体） | App Store で公開、`apps/App1/` | 9〜14、17〜18 | UIKit、MVVM、RxSwift、Concurrency、API 通信、テスト、CI/CD、Firebase、App Store リリース、相互運用（UIHostingController） |
| App2（SwiftUI 主体） | TestFlight で配信、`apps/App2/` | 19〜22 | SwiftUI、@Observable、NavigationStack、SwiftData、Concurrency、相互運用（Representable）、テスト、CI |
| 技術記事1〜3 | Zenn または Qiita | 14、18、22 | 技術発信 |
| OSS への PR 2件 | GitHub | 7、19（＋23） | OSS 貢献、Git の作法 |
| 毎日の課題と PR | このリポジトリ | 全週 | Git でのチーム開発の作法、基礎の定着 |

## 遅れたときの調整
卒研や授業で時間が減る週は、その週の初めに申告する。先生役は次の順番で課題を削り、App Store 公開（第14週）と月1回のAIなし課題は動かさない。

1. 週末課題の発展部分（任意と書いた項目）
2. 毎日の課題のうち、同じ内容を別の書き方で繰り返すもの（例：第8週の Combine での書き直し）
3. App2 の任意機能（Remote Config、App Store 公開）
4. 第23週の大規模コードの改修 PR（読解と図は残す）

2週以上遅れた場合は、フェーズ5の App2 の範囲を縮小し（お気に入りの保存を Codable にする等）、フェーズ3の公開期限を優先する。
