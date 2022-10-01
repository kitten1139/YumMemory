# YumMemory
![ロゴ](https://raw.githubusercontent.com/kitten1139/YumMemory/main/app/assets/images/logo.png)

## サイト概要
### サイトテーマ
スーパーで購入した商品(食品)を記録・レビューするサイト。

### テーマを選んだ理由
私は日常的によくスーパーで買い物をします。  
その際、以前購入して美味しかった商品の名前やパッケージを思い出せず、 パッケージは似ているけれど味は全く違う商品を買ってしまい失敗することがよくあります。  
周りでも スーパーで買った商品を感想と共に一括に記録できていたら便利だと感じるという声が多かったため、課題を解決したいと考えこの題材を選びました。  
サイト内では商品のパッケージ画像、商品名に加え、味の詳細な感想なども記録することができます。  
また、他のユーザーの投稿も閲覧できるようになっており、商品を購入する際の参考にもできます。  
食品レビューサイトは多く存在し、買ったことのない商品の購入を検討した際に使用したこともありますが、コンビニ商品などのレビューを取り扱っているサイトが多く、スーパによくあるマイナーな商品まではなかなかヒットしないサイトが多いと感じました。  
スーパーでよく見る食品のみの記録に限定することで検索もよりしやすくなると考えました。  
また、商品レビューの投稿を任意にし、公開非公開を選択できるようにすることでより手軽に誰でも記録できるようになると感じました。  
加えて、好みに合わない商品を購入してしまう機会が減ることで食品ロスも減らすことができると考えました。  

### ターゲットユーザー
- スーパーでよく買い物する人
- レビューを参考にしたい人
- 購入した商品を記録しておきたい人

### 主な利用シーン
- 以前購入した商品を思い出したい時
- 食べた商品の画像や感想を記録しておきたい時
- 興味を持った商品の味が知りたい時
- 似たような商品の中から自分に合う商品を選びたい時
- お気に入りの商品の情報をシェアしたい時

### 注意事項
ユーザーアイコンで使用する画像や投稿に使用する商品画像は著作権侵害にあたるものかどうかをご確認の上、ご使用いただくようお願いいたします。

## 設計書

![ER図](https://raw.githubusercontent.com/kitten1139/YumMemory/4e55b8887c341816847ab29c439ec837adce3383/app/assets/images/ER%E5%9B%B3.png)

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
- 並び替え表示機能
- 投稿の公開/非公開機能

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

## ポートフォリオ閲覧用アカウント
### 会員側
#### <メールアドレス>
a-chan@yummemory.com
#### <パスワード>
demono.2

### 管理者側
#### <メールアドレス>
admin@yummemory
#### <パスワード>
yummemoadmin