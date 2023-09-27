# グルメでGO
グルメでGOは、グルメの写真をレビュー投稿サイトです。
美味しい料理や雰囲気の良い飲食店の写真を位置情報付きで共有できます。
レスポンシブ対応しているのでスマートフォンからでもご利用できます。
![スクリーンショット 2023-09-27 18 35 31](https://github.com/Ryo0203VB/gourmet/assets/135448649/521b9394-fe53-4c44-94ef-0a03f646e104)
![スクリーンショット 2023-09-27 16 02 23](https://github.com/Ryo0203VB/gourmet/assets/135448649/0715deff-ced0-49c0-8d4b-77161ab43f1e)

## サイトURL
http://44.197.193.199/
画面中部のゲストログインから、メールアドレスとパスワードを入力せずにログインできます。

## サイト概要
### サイトテーマ
身近な人の投稿が、気になっているお店や行ってみたいと思っているお店に行きやすくするレビューサイト
​
### テーマを選んだ理由
もともと、色々な料理を食べるのが好きなのですが、新しいお店を探したり、行ったことのないお店に行くのが、
少し不安で、行きにくいと感じる部分もありました。他のレビューサイトなどを観ると写真やレビューが良いことしか
書いてなく実際に利用した人の写真やコメントが少なく見受けられます。そこで、サイトの写真と実際のお店と
のギャップが生まれないようにするために、個人がレビューを投稿することで、お店探しを簡単にするだけではな
く、お店に生きやすくして、サイトとレビューのギャップが生まれないようにしたいと考え、このテーマにしました。
​
### ターゲットユーザ
- 食べることが好きな人
- 行ったことのないお店に行ってみたい人
- その時のご飯や飲み会などで困っている人

### 主な利用シーン
- 食べたいもの探している時
- 気になっているお店の評判や味が気になっている時
- 行ったことのお店を探している時
- 自身が行ったお店のレビューをする時

## 設計
◆ER図
![image](https://github.com/Ryo0203VB/gourmet/assets/135448649/0e98a091-da2f-4d4b-a4c0-b4fac269d456)

​
## 開発環境
- OS：macOS Ventura 13.4.1
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- API:Google Map API
​
## 機能一覧
- ユーザー登録、ログイン機能(devise)
- 管理者機能(devise)
- 投稿機能(Active Storage)
- いいね機能(Ajax)
- コメント機能(Ajax)
- フォロー機能
- DM機能
- ページネーション機能(kaminari)
- 検索機能(ransack)
- Google Map API(geocoder)

## 使用素材
- 【PAKUTASO】 https://www.pakutaso.com/
