# pstdn<br>
ポストドン。スクリプト経由でmastodonに文字列トゥートできます(るび〜処女作)<br>
<br>
![DeskTop](https://media.mstdn.jp/images/media_attachments/files/005/756/219/original/fa43db9d71229f25.png)

# なにこれ？<br>
察して下さい<br>
<br>
# できること、できないこと<br>
あくまで文字トゥートができればそれでよかったのでそれ以外実装していません<br>
画像トゥートできるようにもしたいけどやる気次第です<br>
また自分の技術力不足、及び例外を一切考慮していない雑な設計のため不具合が絶対出ます<br>
その時はIssuesか hilite_menthol@mstdn.jp に報告してください<br>
ただしこれもやる気次第なのでやらないかもしれない。ごめんね<br>
<br>
# 必須gem<br>
・mastodon https://rubygems.org/gems/mastodon API叩くのに使ってます、これは最低限入れといてください<br>
<br>
# 下準備<br>
分かる人には3行で説明できます<br>
・アクセストークン取って、'MASTODON_ACCESS_TOKEN'の名前で環境変数つくる(面倒だったらスクリプト内部のローカル変数に書き換えるなりご自由にどうぞ)<br>
```Bash
$ export MASTODON_ACCESS_TOKEN='INSERT ACCESS_TOKEN TO HERE'
```
・インスタンス変えたければスクリプトの中の'MASTODON_HOST'の変数の中身を書き換えて下さい。デフォは https://mstdn.jp です<br>
```ruby
require 'mastodon'

MASTODON_HOST = 'https://mstdn.jp'
#この中身変えればインスタンス変更できます。サポートはしませんがご自由にどうぞ
```

・コマンドライン上で実行してやって下さい、ただし常駐するので1回だけトゥートして消える感じの方には向きません<br>
<br>
わからない人にはブログかどっかでもうちょっと手とり足取りちゃんと書くのでお待ち下さい<br>
<br>
# つかいかた<br>
トゥートする文面を入力して改行した後Ctrl+Dでトゥートされます<br>
スクリプトを止めたい場合は1行目の段階で'exit'と打ち込んで改行したのち、Ctrl+Dを叩けば止まります<br>
また、文面を途中で誤字ってキャンセルしたい(コマンドライン上が文字まみれになって消したい場合)ときは '!clear' と入力すれば消えます。<br>
<br>

# 注意事項
プロキシを通していると一生待機状態のまま動かない状態に陥ります。<br>
gemのネットワーク設定が自動のままであることが原因っぽいので、その場合はお手数ですが環境変数を追加で2つ設定してください。

```Bash
$ export http_proxy='ADDRESS:PORT NUMBER'
$ export https_proxy='ADDRESS:PORT NUMBER'
```

# 更新履歴<br>
2018/08/16 (Thu) Ver0.57 何も入力されていない状態でCtrl+Dを押すとエラーで強制停止する問題を修正<br>
2018/06/14 (Thu) Ver0.55 出力の際の一部メソッド、及び出力の際のソース変更<br>
起動の際にログインしているインスタンスを表示するように<br>
2018/06/09 (Fri) Ver0.53 トゥート文面キャンセルを兼ねたコマンドラインを掃除する機能(!Clearのやつ)実装<br>
2018/06/07 (Thu) 初版公開、ver0.50とでもしておきます
