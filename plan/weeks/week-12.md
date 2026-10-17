# 第12週（2027-01-02 土〜01-08 金）：CI/CD（GitHub ActionsとFastlane）とTestFlight

> この計画が想定する前提：App1 の主要機能とテストがそろい、Apple Developer Program の登録が完了している。リポジトリは公開で、App1 は `apps/App1/` にある。週25h。

## 目標
- PR を作るたびに GitHub Actions で App1 のビルドとテストが自動で走り、結果が PR に表示される。
- Fastlane でテストと TestFlight へのアップロードをコマンド1つで実行できる。
- 署名用の鍵と App Store Connect API キーを、リポジトリに入れずに GitHub の Secrets で扱える。
- App1 を TestFlight で自分の iPhone に配信する。

## 学習項目
- GitHub Actions：workflow の構文、macOS ランナー、ランナーにある Xcode のバージョンの確認と選択、`paths` による対象ディレクトリの絞り込み（このリポジトリは日々の課題も含むため）
- `xcodebuild test` と、シミュレータの指定（`-destination`）
- Fastlane：`Fastfile`、`scan`（テスト）、`gym`（ビルド）、`pilot`（TestFlight）、App Store Connect API キー
- 署名：証明書・プロビジョニングプロファイル・Bundle ID の関係。CI で使う方法（Fastlane `match` または手動で Secrets に登録）
- GitHub Secrets と、ログに秘密情報を出さない注意点
- 参考：Xcode Cloud（Apple の CI）。GitHub Actions との違いを説明できればよく、導入は任意

## 教材
- GitHub Docs「Building and testing Swift」https://docs.github.com/actions/use-cases-and-examples/building-and-testing/building-and-testing-swift
- GitHub Actions のランナー画像（macOS の Xcode 一覧）https://github.com/actions/runner-images
- fastlane docs「iOS Getting Started」https://docs.fastlane.tools/getting-started/ios/setup/
- fastlane docs「App Store Connect API」https://docs.fastlane.tools/app-store-connect-api/
- Apple「Xcode Cloud」https://developer.apple.com/xcode-cloud/

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| 共通 | 教材（GitHub Actions、Fastlane、署名） | 4.5 |
| 共通 | PR 時のビルド・テストの workflow | 5.0 |
| 共通 | Fastlane の test レーンと beta レーン | 5.0 |
| 共通 | 署名・API キー・Secrets の設定 | 4.0 |
| 共通 | TestFlight での配信と実機確認 | 2.5 |
| 共通 | 振り返り（CI の構成図を README に書く） | 2.5 |
| 共通 | 定着確認 | 1.5 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | PR 時に App1 のビルドとテストを行う workflow を書く（`apps/App1/` の変更時だけ動かす） | `.github/workflows/`（作成前に承認を得る） |
| 日 | Fastlane を導入し、手元で `fastlane test` が通るようにする | `apps/App1/fastlane/` |
| 月 | App Store Connect でアプリを登録し、API キーを作って Secrets に入れる | 外部サービス |
| 火 | `fastlane beta` で TestFlight にアップロードする（まず手元から） | `apps/App1/` |
| 水 | 同じ処理を GitHub Actions から手動実行（`workflow_dispatch`）できるようにする | `.github/workflows/` |
| 木 | わざとテストを失敗させた PR を作り、CI が失敗を示してマージを防げることを確かめる | `apps/App1/` |
| 金 | 定着確認：Diffable Data Source（第5週） | `0108/` |

## 完了条件
- [ ] App1 に関する PR で CI が自動で走り、成功・失敗が PR 画面に表示される。
- [ ] 日々の課題（`MMDD/`）だけを変更した PR では、App1 の CI が動かない。
- [ ] `fastlane beta` で TestFlight にアップロードでき、自分の iPhone で TestFlight からインストールできる。
- [ ] リポジトリの全履歴に、証明書・秘密鍵・API キーが含まれていない（`git log -p` で確認する）。
- [ ] 証明書・プロファイル・Bundle ID の関係を図で説明できる。

## 成果物
- `.github/workflows/` の CI 設定、`apps/App1/fastlane/`、TestFlight のビルド

## 定着確認
- 第5週：Snapshot と識別子の設計
