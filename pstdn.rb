MASTODON_HOST = 'https://mstdn.jp'      #この中身変えればインスタンス変更できます。サポートはしませんがご自由にどうぞ

system ('clear')                        #起動時にコマンドラインキレイキレイに
puts "** 終了させたい場合は 'exit' と入力して改行したのち、 Ctrl+D を叩いて下さい **"

#curl -X POST -d "status=膣&spoiler_text=test" --header "Authorization: Bearer $MASTODON_ACCESS_TOKEN" -sS https://mstdn.jp/api/v1/statuses;
curl_base = "curl -o /dev/null -w '%{http_code}\n' -X POST --header \"Authorization: Bearer \"" + ENV['MASTODON_ACCESS_TOKEN'] + " -s https://mstdn.jp/api/v1/statuses "


loop{    
    print "text>>"
    input_Text = readlines
    $CW_flag = nil
    curl_status = nil
    curl_cmd = nil

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
            #トゥート処理、ただしCWの有無で分岐する
            curl_status = "-d \"status=" + input_Text.join

            if $CW_flag != true then
                curl_status += "\""
                curl_cmd = curl_base + curl_status
                
                toot = system(curl_cmd)
            else
                curl_status += "&spoiler_text=" + CW_text + "\""
                curl_cmd = curl_base + curl_status

                toot = system(curl_cmd)

            end    
        end
    
    end
}
