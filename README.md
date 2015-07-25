[WIP]Komonjo
====

## Overview

Komonjo helps you to manage your slack logs!

## Description

Under construction...

## Demo
Under construction...

## Requirement

All dependencies are written in `Gemfile`.  
So all you have to do is `bundle install`.

* Ruby
  * sinatra
  * sinatra-contrib
  + slack-api
  * dotenv
  * slim
  * compass
* Slack api_token

## Usage

First, setup server and access to `localhost:9292`

```bash
$ rackup
Thin web server (v1.6.3 codename Protein Powder)
Maximum connections set to 1024
Listening on localhost:9292, CTRL+C to stop
```

Second, enter `api_token` and `channel_name`

note: if you don't have `api_token`, you can get it from this page.  
[Slack Web API](https://api.slack.com/web)

note: we accept both `channel_name` with '#' at its head and without '#'  
ex: `#general` equals `general`

## Install

please `git clone` and `bundle install`

## Contribution

Anything is welcome :+1:  
e.g. fix typo, fix bugs, refactoring...

## Licence

[MIT](https://github.com/hkdnet/komonjo/blob/master/LICENSE)

## Author

[hkdnet](https://github.com/hkdnet)
