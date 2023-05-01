家の消費財の在庫管理を行うflutterのスマホアプリを開発したい。
DBはsqliteを利用する予定です。

画面構成と機能は以下
1. トップページ
　在庫切れになりそうで買い物時期が近づいている商品を教えてくれる
　買ったら購入済みボタンを押すとupdate_dateがアップデートされ買い物時期のカウントがupdateされる
　何もデータがない時は「在庫データが存在しません」と表示し、「在庫データを登録する」と言うリンクから在庫登録画面へのリンクボタンが表示される
2. 在庫登録画面
　消費財の情報を登録する
　商品名(require)、購入先(optional)、なくなるタイミング(require)、通販用URL（optional）を入力する。
　簡易的な型によるバリデーションは存在。
　登録ができたら「登録できました」のポップアップが表示される
3. 在庫状況確認画面
　登録した消費財の一覧を確認できる
　商品名、次の購入時期、購入先、価格が確認できる
　在庫情報は画面内に横2個*縦3個のコンテナが並ぶように表示させたい
　何もデータがない時は「在庫データが存在しません」と表示し、「在庫データを登録する」と言うリンクから在庫登録画面へのリンクボタンが表示される
4. 左ナビゲーション
　各画面から自由に遷移ができるようにする

消費財のスキーマ設計
 商品名(require)、購入先(optional)、なくなるタイミング(require)、通販用URL（optional）が登録される
 スキーマにはupdate_dateとなくなるタイミングから計算された買い物時期(timestamp型)が登録される

ディレクトリツリーは以下
stock_mate/
├─ lib/
│   ├─ models/
│   │   └─ inventory_item.dart
│   ├─ pages/
│   │   ├─ inventory_registration_page.dart
│   │   └─ inventory_status_page.dart
│   ├─ services/
│   │   ├─ database_helper.dart
│   │   └─ utils.dart
│   ├─ main.dart
│   └─ app.dart
├─ test/
│   └─ main_test.dart
└─ pubspec.yaml
