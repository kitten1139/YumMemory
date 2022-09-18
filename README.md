# YumMemory
![ロゴ]()

## サイト概要
### サイトテーマ
スーパーで購入した商品(食品)を記録・レビューするサイト。

### テーマを選んだ理由
スーパーで買い物をする際に、以前購入して美味しかった商品の名前やパッケージを思い出せず、
パッケージは似ているけれど味は全く違う商品を買ってしまい失敗することがよくあります。
そのため、スーパーで買った商品を一括に記録できていたら便利だと思いました。
サイト内では商品画像、商品名、説明に加え、味の詳細な感想なども記録することができます。
また、他のユーザーの投稿も閲覧できるようになっており、商品を購入する際の参考にもできます。
スーパーに限定したECサイトはありますがレビューも載っているものは少なく、逆に食品のレビューサイトは幅が広すぎて
検索にヒットしづらいので、このサイトでスーパーの食品に限定した記録を残せることで、より手軽に検索することができます。
加えて、好みに合わない商品を購入してしまう機会が減ることで食品ロスも減らすことができると考えました。

### ターゲットユーザー
- スーパーでよく買い物する人
- レビューを参考にしたい人
- 購入した商品を記録しておきたい人

### 主な利用シーン
- 食べた商品の画像や感想を記録しておきたい時
- 興味を持った商品の味が知りたい時
- 似たような商品の中から自分に合う商品を選びたい時
- 以前購入した商品を思い出したい時

### 注意事項
ユーザーアイコンで使用する画像や投稿に使用する商品画像は著作権侵害にあたるものかどうかをご確認の上、ご使用いただくようお願いいたします。

## 設計書

![ER図]()

## 主な機能

### 一般ユーザー

- ログイン機能
- 投稿機能
- レビュー機能
- 投稿いいね機能
- 投稿コメント機能
- 投稿検索機能
- 絞り込み表示機能
- ゲストログイン機能
    - 投稿の閲覧、コメント、いいねのみ

### 管理ユーザー

- ユーザー情報編集
- ユーザー退会
- 投稿削除
- 商品カテゴリ作成


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
