# 第13週（2027-01-09 土〜01-15 金）：App1 のリリース準備と審査提出

> この計画が想定する前提：App1 が TestFlight で動き、CI が整っている。審査は数日かかることがあり、却下された場合は第14週で対応する。週25h。

## 目標
- Instruments でメモリリークと重い処理を調べ、見つかった問題を直す。
- VoiceOver と Dynamic Type に対応し、HIG に沿っているかを自分で点検する。
- App Privacy（プライバシーの申告）、プライバシーポリシー、スクリーンショット、説明文をそろえ、**第13週中に審査へ提出する**。

## 学習項目
- Instruments：Leaks、Allocations、Time Profiler。起動時間とスクロールの重さの計測
- アクセシビリティ：`accessibilityLabel`、`accessibilityTraits`、VoiceOver での操作確認、Dynamic Type、色のコントラスト
- App Store Connect：App Privacy の申告（Firebase が集めるデータを含む）、プライバシーマニフェスト（`PrivacyInfo.xcprivacy`）、年齢区分、スクリーンショットのサイズ
- 審査に出す前の確認：クラッシュがないこと、ログインが不要なこと、未完成の画面がないこと

## 教材
- Apple Today チュートリアル「Examining accessibility in Today」https://developer.apple.com/tutorials/app-dev-training/examining-accessibility-in-today
- Apple「Instruments Help」https://help.apple.com/instruments/
- Apple「App privacy details on the App Store」https://developer.apple.com/app-store/app-privacy-details/
- Apple「Privacy manifest files」https://developer.apple.com/documentation/bundleresources/privacy-manifest-files
- Develop in Swift「Submit your app」https://developer.apple.com/tutorials/develop-in-swift/submit-your-app

## 時間配分（合計25.0h）
| 区分 | 内容 | 時間 |
|---|---|---|
| UIKit | Instruments による計測と修正 | 4.5 |
| UIKit | アクセシビリティ対応と HIG の点検 | 4.5 |
| 共通 | App Privacy、プライバシーポリシー、プライバシーマニフェスト | 3.5 |
| 共通 | スクリーンショット・説明文・キーワードの作成 | 3.5 |
| 共通 | 最終確認（実機での全機能テスト）と審査提出 | 3.5 |
| 共通 | 振り返り | 2.0 |
| 共通 | 定着確認 | 1.5 |
| UIKit | 予備（不具合修正） | 2.0 |

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | Instruments でリークと重い処理を調べ、結果と修正を PR に書く | `apps/App1/` |
| 日 | VoiceOver で全画面を操作し、読み上げが不自然な箇所を直す。Dynamic Type の最大値で確認する | `apps/App1/` |
| 月 | プライバシーポリシーを書き、公開する（GitHub Pages など） | `apps/App1/docs/` |
| 火 | App Privacy の申告とプライバシーマニフェスト | App Store Connect、`apps/App1/` |
| 水 | スクリーンショットと説明文 | App Store Connect |
| 木 | 実機で全機能の最終確認を行い、**審査に提出する** | App Store Connect |
| 金 | 定着確認：画面遷移とデリゲート（第3週） | `0115/` |

## 完了条件
- [ ] Instruments の Leaks で、主要な操作（一覧 → 詳細 → 編集 → 戻る）を5回繰り返してもリークが出ない。
- [ ] VoiceOver だけで、データの追加・編集・削除ができる。
- [ ] App Privacy の申告内容と、Firebase が実際に集めるデータが一致していることを説明できる。
- [ ] 審査への提出が完了している（App Store Connect の状態が「審査待ち」以降になっている）。

## 成果物
- 審査に提出した App1、プライバシーポリシー

## 定着確認
- 第3週：画面遷移とデリゲート
