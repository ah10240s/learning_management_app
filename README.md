# アプリケーション名

勉強スケジュール管理サービス

# アプリケーション概要

自分で登録した科目の学習予定を登録し、スケジュール管理、進捗管理を行うWEBサービスです。作成にあたりいくつか参考にした類似のサービスはありますが、DB設計や機能要件の定義等、基本的には自分で考え作成したオリジナルのWEBサービスです。

# URL

<https://mighty-river-08359.herokuapp.com/users/sign_in>

※下記テストアカウントにてログインする事が可能です。  
 ユーザー名：ユーザー1  
 パスワード：111111

# 機能一覧&使用技術

* プラットフォーム（Heroku、AWS ElasticBeanstalk）
* データベース（PostgreSQL）
* cssフレームワーク (AdminLTE3、Bootstrap)
* ユーザー登録、ログイン (devise)
* グラフ描画 (Chart.js)
* データ一覧表示(データテーブル表示)、データ絞込、データ並び替え、ページネーション (datatables)
* カレンダー表示 (fullcalendar)
* 勉強科目登録・編集・削除
* 勉強予定登録・編集・削除
* 勉強完了済処理 (一部Ajax)
* 学習済勉強時間の集計
* 学習済勉強時間の集計条件の変更 (一部Ajax)
* 勉強グループ作成・編集・削除
* 勉強ブループへの招待・参加・退会
* 同グループメンバーの学習済勉強時間の集計

