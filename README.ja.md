[WIP]Komonjo
====

## 概要

KomonjoはSlackのログ管理ツールです。

## 詳細

準備中

## デモ

準備中

## 必要要件

Ruby製なので以下のgemが必要です。これらは`bundle install`で全て解決されます。  
また、Slackのログ取得用に`api_token`が必要です。取得方法は後述します。  

* Ruby
  * sinatra
  * sinatra-contrib
  + slack-api
  * dotenv
  * slim
  * compass
* Slack api_token

## Usage

ローカル環境にサーバーを立てて使うことになります。

まず、サーバを立ち上げ`localhost:9292`にアクセスします。  
サーバは`rackup`で立ち上がります。  
※ インストール時に`bundle install`していない場合はここで実施してください。

```bash
$ rackup
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
```

次に`api_token`と`channel_name`を入力します。  
`api_token`は [Slack Web API](https://api.slack.com/web) から入手可能です。  
`channel_name`は先頭に'#'があってもなくても構いません。

## Install

`git clone`して、`bundle install`してください。

```bash
$ git clone git@github.com:hkdnet/komonjo.git
$ cd komonjo
$ bundle install
```

## Contribution

typo指摘、バグ修正、リファクタリング、なんでも歓迎です。 :+1:  
README.mdの英語を直してくれるととてもよろこびます:moyai:

## Licence

[MIT](https://github.com/hkdnet/komonjo/blob/master/LICENSE)

## Author

[hkdnet](https://github.com/hkdnet)
