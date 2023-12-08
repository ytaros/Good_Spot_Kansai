# [関西、めっちゃええとこ。]
[![Image from Gyazo](https://i.gyazo.com/0b876ea6b738b2e814363f160484046e.png)](https://gyazo.com/0b876ea6b738b2e814363f160484046e)
<br>
[![Ruby](https://img.shields.io/badge/Ruby-v3.1.4-CC342D?logo=Ruby&logoColor=CC342D)](https://www.ruby-lang.org/ja/news/2023/03/30/ruby-3-1-4-released)
[![Rails](https://img.shields.io/badge/Rails-v7.0.8-CC0000?logo=Ruby-on-Rails&logoColor=CC0000)](https://rubyonrails.org/2023/3/13/Rails-7-0-4-3-and-6-1-7-3-have-been-released)
![JavaScript](https://img.shields.io/badge/JavaScript-%23F7DF1E.svg?style=flat&logo=javascript&logoColor=black)
![TailwindCSS](https://img.shields.io/badge/tailwindcss-%2338B2AC.svg?style=flat&logo=tailwind-css&logoColor=white)
![Postgres](https://img.shields.io/badge/postgres-%23316192.svg?style=flat&logo=postgresql&logoColor=white)
![RSpec](https://img.shields.io/badge/-RSpec-red?logo=ruby&logoColor=white&style=flat)
![GitHub](https://img.shields.io/badge/github-%23121011.svg?style=flat&logo=github&logoColor=white)
![Render](https://img.shields.io/badge/render-%23430098.svg?style=flat&logo=render&logoColor=white)
## サービス概要
『関西、めっちゃええとこ』は、関西に特化した『風景』や『食』を画像付きで投稿しあう情報交換アプリです。<br>

### ▼ サービスURL
https://www.goodspotkansai.com/


## 想定されるユーザー層<br>

関西在住ないし住われた経験がある方で、お勧めスポットを知っている人<br>
旅行が好きな人<br>
関西が好きな人<br>
関西旅行を考えていて、どこに行こうか迷っている人<br>
<br>

## サービスコンセプト

私は生まれ育った関西の食や文化、人がとても大好きです。また、知る人ぞ知るようなスポットに訪れることも大好きです。<br>
旅先では、美味しいお店を探すときは情報量の多いネットの不特定多数の口コミを調べるよりも先に、一軒目は BAR に入ってマスターからおすすめスポットやお店の情報を得ます。<br>
そうして訪れたお店の料理が美味しかった時は、まさに宝物を見つけたような気持ちになります。<br>
現地の人が知る情報の中にこそ名店や名景色があると考え、 関西 × 現地の情報 = めっちゃええとこ を関西に住まう人や関西以外の人に向けても発信できるようなアプリを企画しました。<br>
<br>

### 本サービスの機能は以下の通りです。

・関西地図から、府県を選択 → 市町村を選択。利用者がここに行って良かった！って思えるお店、料理、風景を写真投稿できます。<br>
・投稿時はタイトル、写真、住所、カテゴリを選択。GoogleMap API を利用し、住所と位置情報を紐づかせます。<br>
・タイトル、タグでマルチ検索ができます。<br>
・お気に入りの投稿画像を登録した際、画像を投稿した際に、X でも共有することができます。<br>
・閲覧者の位置情報から ◯◯km 範囲のスポットを検索することができます。<br>
・投稿があった際は LINE 通知機能により通知されます。<br>
・投稿が多い県にランキング機能をつけます。<br>
<br>

### 他のサービスと比較して差別化できるポイントは以下の通りです。

類似サービスとして、以下のものが挙げられます。<br>
・[Instagram](https://www.instagram.com/)<br>
・[食べログ](https://tabelog.com/)<br>
対して、本サービスの差別化ポイントは以下の通りです。<br>
<br>
関西特化: 関西地域に特化しており、関西の風景や食事情報を中心に提供しています。関西圏の情報にフォーカスしているため、地域愛や地元の魅力を強調できます。<br>
現地の情報共有: 現地ユーザー、旅行ユーザーが訪れたスポットやお店の情報を共有する情報交換サービスです。現地の情報やおすすめスポットを発見しやすくし、情報誌でよく取り上げられるスポット以外の情報を旅行者に提供します。<br>
Google Map 連携:　ユーザーの位置情報を基に投稿された写真の位置情報を紐付けて近場で行けるスポットをピックアップします。<br>
地域ランキング:　投稿が多い県にランキング機能を導入する予定です。ユーザーによる評価が反映されます。<br>
タグ付けとマルチ検索: 写真にタグを付ける機能やマルチ検索を提供し、ユーザーが効果的に情報を見つけやすくします。<br>
X 共有機能:　お気に入りの投稿画像を他のユーザーと共有できる機能を提供します。これにより、ユーザー同士の交流と情報共有が促進されます。<br>
「関西、めっちゃええとこ」は、関西地域の魅力や現地情報をユーザーに提供することを目指します。<br>
<br>

## 実装を予定している機能

・会員登録機能<br>
・ログイン機能・ゲストログイン（閲覧のみ）<br>
・プロフィール機能（編集）<br>
・記事（写真）投稿機能<br>
・記事（写真）編集機能<br>
・記事（写真）削除機能<br>
・タグ投稿機能<br>
・タグ編集機能<br>
・タグ削除機能<br>
・カテゴリ投稿機能<br>
・カテゴリ編集機能<br>
・カテゴリ削除機能<br>
・お気に入り設定機能<br>
・お気に入り解除機能<br>
・マルチ検索・オートコンプリート（タグ・タイトル・カテゴリ）<br>
・X 共有機能<br>
・Google API の導入<br>
・エリアランキング表示機能<br>
・おすすめスポット表示機能<br>
・管理ユーザー機能<br>
・テスト機能(Rspec)<br>
・LINE 通知機能<br>
<br>

### MVP

・会員登録機能<br>
・ログイン機能・ゲストログイン（閲覧のみ）<br>
・プロフィール機能（編集）<br>
・記事（写真）投稿機能<br>
・記事（写真）編集機能<br>
・記事（写真）削除機能<br>
・タグ投稿機能<br>
・タグ編集機能<br>
・タグ削除機能<br>
・カテゴリ投稿機能<br>
・カテゴリ編集機能<br>
・カテゴリ削除機能<br>
・お気に入り設定機能<br>
・お気に入り解除機能<br>
・マルチ検索・オートコンプリート（タグ・タイトル・カテゴリ）<br>
・X 共有機能<br>
・Google API の導入<br>
<br>

### その後の機能

・エリアランキング表示機能<br>
・おすすめスポット表示機能<br>
・管理ユーザー機能<br>
・テスト機能(Rspec)<br>
・ImageMagick<br>
・LINE 通知機能<br>

## 使用するAPI
* Geocoding API
* Geolocation API
* Maps JavaScript API
* Places API (New)
* LINE Developers API

## 技術選定<br>
* フロントエンド<br>
  JavaScript<br>
  Node v16.19.0<br>
* CSSフレームワーク<br>
  Tailwind css<br>
* バックエンド<br>
  Ruby on Rails 7.0.8<br>
  Ruby 3.1.4<br>
* RDS<br>
  PostgreSQL<br>
* 認証・認可<br>
  Sorcery<br>
* デプロイ<br>
  Render<br>
* バージョン管理<br>
  GitHub<br>
* テスティング<br>
   RSpec<br>
   Capybara<br>
   rubocop
## 画面遷移図

[画面遷移図](https://www.figma.com/file/0hVSIrNZLaWj0WxgWYw1XZ/KansaiArea?type=design&node-id=0-1&mode=design&t=7XKRz2ioLjAQyCDY-0)

## ER 図

[![Image from Gyazo](https://i.gyazo.com/7ffc9d380c476aad7e46149aa8e9f10b.png)](https://gyazo.com/7ffc9d380c476aad7e46149aa8e9f10b)
