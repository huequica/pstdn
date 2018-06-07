require 'mastodon'

MASTODON_HOST = 'https://mstdn.jp'      #この中身変えればインスタンス変更できます。サポートはしませんがご自由にどうぞ

connection = Mastodon::REST::Client.new(base_url: MASTODON_HOST, bearer_token: ENV['MASTODON_ACCESS_TOKEN'])



print "** 接続に成功しました **\n"
print "** クライアントを終了させたい場合は 'exit' と入力して改行したのち、 Ctrl+D を叩いて下さい。 **\n"

loop{    
    print "text>>"
    imput_Text = readlines
    
    if imput_Text[0] == "exit" || imput_Text[0] =="exit\n"  then 
        break
    end

    connection.create_status(imput_Text.join)

    print "** Tooted. **\n" + imput_Text.join + "\n"

}