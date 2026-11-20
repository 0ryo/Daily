# 第6週（2026-11-21 土〜11-27 金）の短期目標：WearLog の Phase 1 を作り、Phase 2 の保存に入る

- 作成日: 2026-11-20（学習方針の変更に合わせて先生役が作成。/week が今週の判定のあとで見直してよい）
- 中期目標: 11月「UIKit の基盤と設計・テスト」の 2026-11-20 の方針変更（[goals.md](../goals.md)）、ロードマップ [app-roadmap.md](../app-roadmap.md) の Phase 1
- 第5週からの持ち越し: 11/20（料理教室の予約フォーム、入力検証と return キーの定着確認）が作業中。100点になってから WearLog に入る（終わっていなければ 11/21 はその続きにする）。

## 今週の目標
- `apps/WearLog/` に Xcode プロジェクトを作り、Main.storyboard を使わずに XIB の画面で起動する。
- 服の一覧・登録・詳細・編集・削除を、インメモリのモデルで通して動かす（Phase 1）。
- 機能ごとに main から `feature/機能名` のブランチを切り、1日1 PR を作り、100点になったらマージする流れを毎日回す。
- 服の配列を1つの Store にまとめ、複数の画面が同じデータを使う形にする。
- 服を JSON ファイルに保存し、起動時に復元する（Phase 2 の最初）。

## 課題
| 日 | 課題 | 置き場所 |
|---|---|---|
| 土 | `feature/item-list`：プロジェクトを作り、Main.storyboard を使わずに起動する。`ClothingItem`・`ClothingCategory` とモックの服で一覧を出す（4時間） | `apps/WearLog/` |
| 日 | 【設計】`feature/item-register`：服の登録画面。名前の前後の空白を除いて検証し、登録した服をデリゲートで一覧に返す（4時間） | `apps/WearLog/` |
| 月 | `feature/item-detail`：一覧のタップで服の詳細画面へ進み、名前・カテゴリ・毎回は洗わない服かを表示する | `apps/WearLog/` |
| 火 | `feature/item-edit-delete`：詳細から編集画面を開き、結果をクロージャで返す。一覧のスワイプで削除する | `apps/WearLog/` |
| 水 | `feature/item-sections`：一覧をカテゴリごとのセクションに分ける | `apps/WearLog/` |
| 木 | `feature/item-store`：服の配列を `ClothingItemStore` にまとめ、一覧・登録・編集の画面が同じ Store を使う | `apps/WearLog/` |
| 金 | `feature/item-persistence`：服を JSON ファイルに保存し、起動時に復元する。失敗したときはアラートを出す | `apps/WearLog/` |

弱点ドリルの判定が出た日は、その日の行をドリルにし、行を1日ずつ後ろへずらす（終わらなかった行は来週に回す）。

## 完了条件
- [ ] `apps/WearLog/` が Main.storyboard を使わずに起動し、服の一覧が出る。
- [ ] 服を登録・表示・編集・削除できる。登録と編集の結果が一覧に反映される。
- [ ] 一覧がカテゴリごとのセクションに分かれている。
- [ ] 一覧・登録・編集の画面が、同じ `ClothingItemStore` の服を使う。
- [ ] 服を再起動後も同じ順番で復元できる。
- [ ] 毎日 `feature/機能名` のブランチで PR を作り、100点のあと main へマージしている。

## 来週以降の候補（来週の目標を立てるときに検討する）
- Phase 2 の続き（コーデのモデルと一覧、服の複数選択、写真の選択と保存）。
- HR1（勉強会への参加）。
