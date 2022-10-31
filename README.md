# Stop! Single golf

## サイト概要
![スクリーンショット 2022-07-11 15 37 44](https://user-images.githubusercontent.com/105344687/178203563-71b267fb-6a14-4c5c-a5ff-3b26e6fb2e15.png)
### ◆サイトテーマ
シングルゴルフプレイヤーの架け橋となるSNSサイト

***
### ◆テーマを選んだ理由
新型コロナウィルスの影響により、屋外で密になりにくいスポーツとして制限が掛からなかったゴルフの人気が高まりゴルフ人口が増加している。
又、最近では「ゴルフ=富裕層」とゆう概念も無くなり、安価にゴルフコースをラウンドすることもでき、若者からお年寄りまで幅広い年代でゴルフを楽しんでいます。  
私もゴルフを趣味として、毎日のように打ちっ放し練習場へ行くくらい好きなのですが、ゴルフの醍醐味でもある「ラウンド」には中々いくことができません。 

その要因として  
* `ゴルフ仲間が少ない・いない`
* `自身やゴルフ仲間の引っ越しによる仲間の減少`
* `ラウンドでのソロプレイはクラブ側が禁止している場合もある`
* `ソロプレイ自体ハードルが高く、周りの目を気にして閉鎖的になってしまう`  
 
ゴルフ人口は増加傾向にあるが、その反面シングルプレイヤーも多くいるのが現状である。  
しかし、InstagramやTwitter等のSNSで連絡をして仲間を見つけることもハードルが高いと感じる。  
また、打ちっ放し練習場で声をかけることもハードルが高いと感じる。

そこで、ゴルフ好きが集まるSNSサイトを開発し、ゴルフ仲間を見つけて  
一緒にラウンドを回れるようにしたいと考えた。  
このSNSサイトの開発により、開発前よりラウンドに行く人の人数を増やすことができ  
プレーヤー側・クラブ側共に良い循環となる。  
また、ゴルフ仲間も幅広い年代の人とラウンドすることができ、コミュニティの拡大にも繋がる。

***
### ◆ターゲットユーザ
* 性別: `男女`
* 年齢: `全年代`
* 職業: `全職種`
* 場所: `全国`
* 特徴: `ゴルフに興味のある人` `ゴルフ仲間を探している人` `ゴルフ初心者` `ゴルフコミュニティに所属していない人` `ゴルフが好きな人` `ツアーゴルファー` `ゴルフ練習場に通う人`

***
### ◆主な利用シーン
* `ゴルフラウンドにいきたい時`
* `ゴルフ仲間を探している時`
* `ゴルフ投稿を見たい時`
* `自分のお気に入りのコースを見たい時`
* `ラウンド前の下見をしたい時`
* `ゴルフを始めようとしている時`
* `ラウンドに身につけていくウェアを決めている時`
* `使用しているゴルフボールを参考にしたい時`
* `使用しているクラブを参考にしたい時`
* `ゴルフをしている男性女性の姿を見たい時`
* `自身でラウンドしたコースの平均値を見たい時`

***
## ◆設計書

- 機能一覧

<img width="1361" alt="スクリーンショット 2022-08-28 20 11 51" src="https://user-images.githubusercontent.com/105344687/187071192-1a4225aa-43cb-4b4c-a671-f34ddf11991a.png">

* ER図
<img width="720" alt="スクリーンショット 2022-10-31 15 12 39" src="https://user-images.githubusercontent.com/105344687/198943114-08c956e0-00fc-4919-bb42-f0982dde45a2.png">

* UI FROWS(User)
![Golf-UI Forws(ユーザー側)](https://user-images.githubusercontent.com/105344687/180429441-f5c54968-5a09-4460-b592-9ae41a1c4f70.jpg)

* UI FROWS(admin)
![Golf-UI Frows(管理側)](https://user-images.githubusercontent.com/105344687/180429524-b49087a1-a17a-4f83-a054-486d5d043a63.jpg)

* ワイヤーフレーム

[Stop! Single Golf.pdf](https://github.com/Alexander4649/Stop_Single_Golf/files/9459752/Stop.Single.Golf.pdf)

- テーブル定義書

[テーブル提議書_Stop!_Single_golf.pdf](https://github.com/Alexander4649/Stop_Single_Golf/files/9459697/_Stop._Single_golf.pdf)

- アプリケーション詳細設計

[Stop! Single Golf_WBS - 詳細設計.pdf](https://github.com/Alexander4649/Stop_Single_Golf/files/9457692/Stop.Single.Golf_WBS.-.pdf)

- テスト仕様書

[Stop!Single Golf_テスト仕様書.xlsx.pdf](https://github.com/Alexander4649/Stop_Single_Golf/files/9459821/Stop.Single.Golf_.xlsx.pdf)

***
## ◆開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL,
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
- gem："devise","image_processing","carrierwave","jquery-datetimepicker-rails", "kaminari","rails-i18n","enum_help","dotenv-rails"

***
## ◆取り入れた技術
- ユーザー認証(devise)
- いいね・フォロー・コメント・DM機能の非同期通信(Ajax)
- 通知機能(module,helper)
- 乱数機能(securerandom)
- 複数画像アップロード機能(carrierwave,imageuploader)
- メッセージ画像添付機能(rightbox)
- スライド機能(swiper)
- 自動スクロール機能(JavaScript,scroll)
- カウントダウンタイマー機能(JavaScript)
- ドロップダウンメニュー機能(CSS)
- バッチ処理機能(自動会員完全削除)(whenever/cron)
- スコア入力・自動計算機能(JavaScript,enum,json)

***
## ◆使用素材