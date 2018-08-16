require 'mastodon'

MASTODON_HOST = 'https://mstdn.jp'      #この中身変えればインスタンス変更できます。サポートはしませんがご自由にどうぞ

connection = Mastodon::REST::Client.new(base_url: MASTODON_HOST, bearer_token: ENV['MASTODON_ACCESS_TOKEN'])

system ('clear')                        #起動時にコマンドラインキレイキレイに
puts "** 接続に成功しました: #{connection.base_url} **" 
puts "** クライアントを終了させたい場合は 'exit' と入力して改行したのち、 Ctrl+D を叩いて下さい **"

loop{    
    print "text>>"
    input_Text = readlines

    if input_Text.join == "" then
        puts "\n** なにも入力されていません。文字列を入力してからCtrl+Dを叩いてください。 **\n"
    else 
        #ここからなにか入ってた場合の処理

        if input_Text[0] == "exit" || input_Text[0] =="exit\n"
            break
        end
    
        if input_Text.join =~ /^.*!Clear.*\n/ || input_Text.join =~ /^.*!clear.*\n/         #入力文字列の中に!Clear(大文字小文字判別しない)が含まれた場合
            system ('clear')                                                                #トゥートごとキャンセルしてコマンドラインもきれいにする
        else
            toot = connection.create_status(input_Text.join)
            print "** Tooted. **\n" + "#{toot.content}" + "\n"
        end
    
    end
}
