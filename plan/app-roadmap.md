# WearLog（App1）のロードマップ

2026-11-21 に学習者がアプリ名を **Patim** に変えた。作業場所はリポジトリ直下の `Patim/`（Xcode プロジェクト `Patim/Patim.xcodeproj`）。この文書の WearLog は Patim と読み替える。

2026-11-20 に学習者と決めた。毎日の課題は、このアプリを1日1 PR ずつ育てる形で出す（大きな弱点が見つかった翌日だけ、1日限定の弱点ドリルにする。判定は daily-review、出題は daily-task）。WearLog は長期目標の App1（UIKit 主体、App Store で公開）として扱う。

- 内容はチャットに全部は出さない（短期目標と同じく、先生役が裏で持つ）。課題を作るときの元にする。
- 先生役が変えてよいのは「進捗」の表と、各 Phase のタスク表の「状態」の列だけ。仕様・Phase の順番・手本の方針を変えるときは学習者の承認を取る。

## 1. アプリの仕様
「この服、何回着たか」を管理するコーディネート記録アプリ。

| 機能 | 内容 |
|---|---|
| 服の登録・一覧 | 手持ちの服を、名前・カテゴリ（トップス／パンツ／アウター／その他）・「毎回は洗わない服か」で登録し、一覧で見る |
| コーデの記録 | その日のコーデを写真1枚で記録し、着た服を一覧から複数選んで紐付ける |
| 着用回数 | 毎回は洗わない服について、洗濯リセット後の着用回数と累計の着用回数を見る |
| 服の詳細 | 着用回数、洗濯リセットのボタン、「この服とよく組み合わせているパンツ」のランキング（同じコーデに入っていた回数の多い順）を見る |
| 天気（API） | コーデを記録するとき、その時点の気温と天気を Open-Meteo から取得して表示し、コーデと一緒に保存する |
| 検索（Phase 4） | 服の一覧を名前で絞り込む |

作らないもの：凝った UI の装飾、アニメーション、ログイン、サーバーへの保存、位置情報の取得（天気の地点は東京に固定する）。

## 2. データモデルの方針
- 着用回数は、服に数を持たせず、コーデの記録から数える（記録を消したり直したりしても、回数が食い違わないようにするため）。
  - 洗濯リセット後の回数 ＝ 服の `lastWashedAt` より後のコーデのうち、その服を含むものの数
  - 累計の回数 ＝ その服を含むコーデの数
- 服とコーデは `UUID` の ID で関連付ける。コーデは服の ID の配列を持つ。
- 写真は Documents の下にファイルとして保存し、コーデはファイル名だけを持つ。
- 保存は Codable と JSON ファイルにする（服とコーデで1ファイルずつ）。Core Data・SwiftData は使わない。

| 型（予定） | 主なプロパティ |
|---|---|
| `ClothingItem` | `id: UUID`、`name: String`、`category: ClothingCategory`、`isReusableBeforeWash: Bool`（毎回は洗わない服か）、`lastWashedAt: Date?` |
| `ClothingCategory` | `tops`・`pants`・`outer`・`other`（`String` の raw value、`CaseIterable`、`Codable`） |
| `Outfit` | `id: UUID`、`date: Date`、`photoFileName: String?`、`itemIDs: [UUID]`、`weather: WeatherSnapshot?`（Phase 3 で追加） |

型名とプロパティ名は予定で、課題を出す日に最終的に決める（設計課題の日は学習者が決める）。

## 3. 実装の手本（実務の書き方に合わせる）
学習者の会社は、MVVM の実装に [Kickstarter の ios-oss](https://github.com/kickstarter/ios-oss) を参考にしている。課題の型の分け方・名前・データの流れは、Phase 3 以降はこの手本に合わせる。課題を作る前とレビューの前に、この節を読む。

### Kickstarter の MVVM の形（ReactiveSwift で書かれている）
手本のファイル：[LoginViewModel.swift](https://github.com/kickstarter/ios-oss/blob/main/Library/Sources/Library/Library/ViewModels/LoginViewModel.swift)、[LoginViewController.swift](https://github.com/kickstarter/ios-oss/blob/main/Kickstarter-Framework/Sources/Kickstarter-Framework/Kickstarter-iOS/Features/Login/Controller/LoginViewController.swift)、[LoginViewModelTests.swift](https://github.com/kickstarter/ios-oss/blob/main/LibraryTests/Library/ViewModels/LoginViewModelTests.swift)

- ViewModel ごとに3つの protocol を作る。`XxxViewModelInputs`（画面で起きたことを受け取る関数）、`XxxViewModelOutputs`（画面がすることを流す値）、`XxxViewModelType`（`inputs` と `outputs` を持つ）。
- 入力の関数は、画面で起きたことで名前を付ける（`viewDidLoad()`、`emailChanged(_:)`、`loginButtonPressed()`）。「何をしてほしいか」では名前を付けない。
- 出力は、画面がすることで名前を付ける（`isFormValid`、`showError`、`dismissKeyboard`）。
- `final class XxxViewModel` が3つの protocol に準拠し、`inputs` と `outputs` は `self` を返す。入力から出力への変換は、すべて `init` の中に書く。
- ViewController は `viewModel: XxxViewModelType` を持ち、`bindViewModel()` で出力を部品に結び付ける。ボタンや入力欄のイベントでは `viewModel.inputs.〇〇()` を呼ぶだけにする。
- 通信などの依存は、`AppEnvironment.current` が持つ protocol の型（例：`apiService: ServiceType`）から使い、テストでは `withEnvironment(...)` でモックに差し替える。
- ViewModel のテストは、出力を `TestObserver` で受けて、入力を順に呼びながら出力の値を確かめる。

### WearLog での置き換え
- Phase 3（RxSwift の前）：上の3つの protocol と `inputs`・`outputs` の形はそのまま使い、出力はクロージャのプロパティ（例：`var isFormValidChanged: ((Bool) -> Void)?`）にする。Phase 4 で出力を RxSwift に置き換える。Rx を入れる前のコードを Rx に移すリファクタリングは、実務でもよくある流れである。
- Phase 4（RxSwift）：入力の裏側を `PublishRelay`／`BehaviorRelay`、出力を RxCocoa の `Signal` か `Driver` にする。ViewController の結び付けは `bind(to:)`・`emit(to:)` と `disposed(by: disposeBag)` にする。Kickstarter の `MutableProperty` と ReactiveSwift の `Signal` を、この対応で読み替える。
- 依存の差し替え：`AppEnvironment.current` が `Environment`（`itemRepository`・`weatherService` などを protocol の型で持つ構造体）を返す形にする。protocol の名前は Kickstarter に合わせて `〇〇Type`、テスト用の実装は `Mock〇〇` にする。
- フォルダ：`Features/画面名/`（ViewController・XIB・ViewModel）、`Models/`、`Services/`、テストは `WearLogTests/` に置く。
- 学習者の会社のコードと書き方が違うと分かったら、会社のコードを優先し、この節を直す（学習者の承認を取って）。

### 実務の進め方（課題で必ず守る）
- ブランチ：アプリの統合ブランチ `patim/main` を main から作り、その日の機能ごとに `patim/main` から `patim/機能名`（例：`patim/item-list`）を切る（2026-11-21 に学習者が決めた）。弱点ドリルの日は main から `drill/MMDD`。
- PR：1日1 PR。説明に「概要・変更点・確認したこと（スクリーンショット）」を書く。PR のマージ先は `patim/main`。100点になったら学習者が `patim/main` へマージし、次の日は最新の `patim/main` からブランチを切る。
- コミット：意味のある単位で分ける。生成物（DerivedData など）と個人の設定（xcuserdata）を `.gitignore` に入れる。
- その Phase で必要なものだけを作る。まだ使わない protocol・汎用化・設定項目を先に作らない（Phase 1〜2 で ViewController が太るのは、Phase 3 で分ける前提として許す。ただし集計や検証のロジックは最初からモデルの型に置く）。
- 課題文では、実務で普通にしない進め方（毎日同じブランチを使い回す、PR をマージしないまま次へ進む、同じ処理を画面ごとにコピーする、テストのためだけに本番のコードを歪める など）を指示しない。迷ったら Kickstarter の手本と、学習者が会社で見ている書き方に合わせる。

## 4. Phase とタスク（1日1 PR。平日2時間、土日4時間）
状態の列は、未着手／作業中／完了（日付）で書く。行の頭の `【設計】` は設計課題の日（daily-task の「設計課題の書き方」で作る）。

### Phase 1：土台（UIKit・XIB・モデル設計。インメモリで動く最小構成）
| 状態 | ブランチ | 内容 | 主なトピック |
|---|---|---|---|
| 完了（2026-11-21） | `feature/item-list` | `apps/WearLog/` にプロジェクトを作り、Main.storyboard を使わずに起動する。`ClothingItem`・`ClothingCategory` とモックの服で一覧を出す（土日・4時間） | SceneDelegate、XIB、UITableView、enum |
| 完了（2026-11-25） | `feature/item-register` | 【設計】服の登録画面。名前の前後の空白を除いて検証し、登録した服をデリゲートで一覧に返す（土日・4時間） | UITextField、UISegmentedControl、UISwitch、デリゲート |
| 未着手 | `feature/item-detail` | 一覧のタップで服の詳細画面へ進み、名前・カテゴリ・毎回は洗わない服かを表示する | UINavigationController、画面への値の渡し方 |
| 未着手 | `feature/item-edit-delete` | 詳細から編集画面を開き、結果をクロージャで返す。一覧のスワイプで削除する | クロージャ、`[weak self]`、UITableView の削除 |
| 未着手 | `feature/item-sections` | 一覧をカテゴリごとのセクションに分ける | `Dictionary(grouping:by:)`、`CaseIterable`、`sorted` |
| 未着手 | `feature/item-store` | 服の配列を `ClothingItemStore`（class）にまとめ、一覧・登録・編集の画面が同じ Store を使う | 参照型と値型、単一の持ち主 |

### Phase 2：コーデ記録・画像・保存・集計
| 状態 | ブランチ | 内容 | 主なトピック |
|---|---|---|---|
| 未着手 | `feature/item-persistence` | 服を JSON ファイルに保存し、起動時に復元する。失敗したときはアラートを出す | Codable、FileManager、`do`/`catch` |
| 未着手 | `feature/outfit-model` | `Outfit` を作り、コーデの一覧画面（日付の新しい順）を作る。写真なし | Date、DateFormatter、`sorted` |
| 未着手 | `feature/outfit-record` | コーデの記録画面で、着た服を一覧から複数選んで保存する | UITableView の複数選択、`Set` |
| 未着手 | `feature/photo-picker` | 記録画面で写真を選び、プレビューする | PHPickerViewController、デリゲート |
| 未着手 | `feature/photo-storage` | 選んだ写真を JPEG で保存し、コーデの一覧に縮小して表示する。コーデも JSON で保存する | `Data`、`jpegData`、ファイル名の管理 |
| 未着手 | `feature/wear-count` | 服の詳細で、洗濯リセット後の回数と累計の回数を表示する | `filter`、`count`、`Date` の比較 |
| 未着手 | `feature/wash-reset` | 詳細の洗濯リセットで `lastWashedAt` を更新し、回数を0に戻す。保存する | 状態の更新と保存 |
| 未着手 | `feature/pants-ranking` | 服の詳細に、一緒に着たパンツのランキングを出す（集計はモデル側の関数） | `flatMap`、`reduce(into:)`、辞書の集計、並べ替えの同点の扱い |
| 未着手 | `feature/phase2-cleanup` | 【設計】Phase 2 の結合確認。記録 → 回数 → リセット → ランキングの流れを通し、ViewController の行数と責務を数えて PR に書く（土日・4時間） | 責務の洗い出し |

### Phase 3：MVVM（Kickstarter の形）と依存の差し替え、天気 API
| 状態 | ブランチ | 内容 | 主なトピック |
|---|---|---|---|
| 未着手 | `feature/item-register-viewmodel` | 服の登録画面を Inputs／Outputs／ViewModelType の形の ViewModel に分ける | protocol、クロージャの出力 |
| 未着手 | `feature/repository` | 保存を `ClothingItemRepositoryType`・`OutfitRepositoryType` の protocol にし、`AppEnvironment` から使う | protocol、依存の差し替え |
| 未着手 | `feature/item-detail-viewmodel` | 服の詳細（回数・リセット・ランキング）を ViewModel に分ける | Inputs／Outputs |
| 未着手 | `feature/weather-service` | Open-Meteo から現在の気温と天気コードを取得する `WeatherServiceType` を作る | `async`/`await`、`URLSession`、`Decodable`、`@MainActor` |
| 未着手 | `feature/outfit-weather` | 【設計】コーデの記録画面で天気を取得して表示し、コーデと一緒に保存する。読み込み中・失敗・再試行を ViewModel の出力で表す（土日・4時間） | 状態の enum、エラー処理 |

天気 API：[Open-Meteo Weather Forecast API](https://open-meteo.com/en/docs)（API キー不要）。例：`https://api.open-meteo.com/v1/forecast?latitude=35.68&longitude=139.76&current=temperature_2m,weather_code&timezone=Asia%2FTokyo`。CP3（MVVM・async/await・ユニットテスト）は、この Phase の終わりの翌日に置く。

### Phase 4：RxSwift（Inputs／Outputs を Rx に）
| 状態 | ブランチ | 内容 | 主なトピック |
|---|---|---|---|
| 未着手 | `feature/add-rxswift` | Swift Package Manager で RxSwift・RxCocoa を入れ、登録画面の入力検証を Rx の出力にする | SPM、`BehaviorRelay`、`Driver`、`DisposeBag` |
| 未着手 | `feature/rx-item-list` | 服の一覧を Store の変更に合わせて Rx で更新する | `Observable`、`bind(to:)` |
| 未着手 | `feature/rx-item-search` | 服の一覧に名前の検索を足す（入力の間引きと重複の除去） | `debounce`、`distinctUntilChanged`、`combineLatest` |
| 未着手 | `feature/rx-item-detail` | 服の詳細の回数・ランキングを Rx の出力にする | `Signal`、`map` |
| 未着手 | `feature/rx-outfit-record` | 【設計】コーデの記録画面（選択・天気）を Rx にする。購読の解放と `[weak self]` を Memory Graph と `deinit` で確かめる（土日・4時間） | 循環参照、`flatMapLatest` |

### Phase 5：実務品質（ユニットテストとエラー処理）
| 状態 | ブランチ | 内容 | 主なトピック |
|---|---|---|---|
| 未着手 | `feature/test-wear-count` | 着用回数の計算のテスト（境界：リセットした当日、記録0件） | Swift Testing、XCTest |
| 未着手 | `feature/test-ranking` | パンツランキングの集計のテスト（同点、パンツなし） | パラメータ化テスト |
| 未着手 | `feature/test-viewmodels` | 登録・詳細の ViewModel のテスト（Mock の Repository に差し替える） | RxTest または値を集める方法、`withEnvironment` の形 |
| 未着手 | `feature/test-weather` | 天気の ViewModel と Service のテスト（失敗・再試行） | 非同期のテスト、Mock の Service |
| 未着手 | `feature/error-handling` | 【設計】保存・読み込み・通信の失敗を、利用者に分かる形で表示する。失敗の種類を enum で表す（土日・4時間） | `Error` の設計、アラート |

Phase 5 のあとは、App1 の公開準備（Apple Developer Program、CI、TestFlight、審査）に進む（plan/goals.md の中期目標）。

## 5. 課題文の形（要件書）
2026-11-22 の課題から、Patim の課題はすべて要件書の形にする（2026-11-21 に学習者から指示。「指示書」の形では、日本語を Swift に直す作業になるため）。daily-task の「設計課題の書き方」で作り、その日に実装する内容（作るもの・使うトピック・条件・確かめること）だけを示す。型の分け方・名前・関数の形・処理の手順は学習者が決める。

- 前日までに学習者が作った型は、要件の中で型名を挙げて指してよい。
- Phase 3 以降で Kickstarter の形（Inputs／Outputs／ViewModelType）を使う日は、形を守ることを「条件」に書き、名前は学習者が決める。

## 6. 進捗
| Phase | 開始 | 完了 | メモ |
|---|---|---|---|
| 1 | 2026-11-21 | | |
| 2 | | | |
| 3 | | | |
| 4 | | | |
| 5 | | | |
