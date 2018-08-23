require 'net/http'
require 'uri'

MASTODON_HOST = 'https://mstdn.jp'      #この中身変えればインスタンス変更できます。サポートはしませんがご自由にどうぞ

system ('clear')                        #起動時にコマンドラインキレイキレイに
puts "** 終了させたい場合は 'exit' と入力して改行したのち、 Ctrl+D を叩いて下さい **"

#インスタンスアクセス前の処理
access_token = ENV['MASTODON_ACCESS_TOKEN']
uri = URI.parse('https://mstdn.jp')
http = Net::HTTP::new(uri.host, uri.port)

http.use_ssl = true

request = Net::HTTP::Post.new('/api/v1/statuses')
request.add_field('Authorization', "Bearer #{access_token}")



loop{    
    print "text>>"
    input_Text = readlines
    $CW_flag = nil

    if input_Text.join == "" then
        puts "\n** なにも入力されていません。文字列を入力してからCtrl+Dを叩いてください。 **\n"
    else 
        #ここからなにか入ってた場合の処理

        if input_Text[0] == "exit" || input_Text[0] =="exit\n"
            break
        end

        if input_Text[0] =~ /^.*!CW .*\n/
            $CW_flag = true
            input_Text[0].slice!(/\A!CW /)
            CW_text = input_Text[0]
            input_Text.delete_at(0)
        else
            $CW_flag = false
        end

        
        if input_Text.join =~ /^.*!Clear.*\n/ || input_Text.join =~ /^.*!clear.*\n/         #入力文字列の中に!Clear(大文字小文字判別しない)が含まれた場合
            system ('clear')                                                                #トゥートごとキャンセルしてコマンドラインもきれいにする
        else
            toot_body = 'status=' + input_Text.join
            #CWの有無で分岐する
            if $CW_flag == true then
                toot_body += '&spoiler_text=' + CW_text
            end

            request.body = toot_body
            response = http.request(request)
            
            #トゥート成功か失敗か確認する
            if response.code == '200'
                puts '** Toot Success. **'
            else
                puts '** エラー起きたかも **'
            end
        end
    
    end
}
