require 'net/http'
require 'uri'
require './param'

#################################################################################
#########################      定義メソッド置き場      #############################
#################################################################################
def visiv_select()
  puts '0 public'
  puts '1 private'
  puts '2 unlisted'
  puts '3 direct(recommend to use Reply only)'
  puts '4 Cancel'
  print '番号を入力してください >>'
  visiv_param = ['public', 'private', 'unlisted', 'direct', false]

  loop do
    number = readline.to_i
    if number.between?(0, 4) then
      return visiv_param[number]
      break
    else
      print '正しい値を入れてください>>'
    end
  end
end

def change_inst()

  $auth_data.each do |data|
    puts "#{$auth_data.index(data)} : #{data["name"]}"
  end

  puts "#{$auth_data.size} : キャンセルして戻る"
  puts '** 番号を選んでください **'
  print '>>'
  input_val = readline.to_i

  if input_val == $auth_data.size
    input_val = false
  end

  return input_val
end

#################################################################################
#########################      main Method      #################################
#起動時インスタンスの選択
running_flag = false
count = 0

while count <= $auth_data.size - 1
  if $auth_data[count]["default"] == true then
    system ('clear')#起動時にコマンドラインキレイキレイに
    running_flag = true


    mastodon_host = "https://#{$auth_data[count]["name"]}"
    access_token = $auth_data[count]["token"]

    uri = URI.parse(mastodon_host)
    http = Net::HTTP.new(uri.host, uri.port)

    http.use_ssl = true

    request = Net::HTTP::Post.new('/api/v1/statuses')
    request.add_field('Authorization', "Bearer #{access_token}")
    puts "** #{$auth_data[count]["name"]}が選択されています **"
    break
  else
    count += 1
  end
end

#どれにもdefaultの中にtrueが入ってなかった場合

if running_flag != true
  puts 'デフォルト指定がされていません。param.rbをいじってください'
  exit
end


puts "** 終了させたい場合は 'exit' と入力して改行したのち、 Ctrl+D を叩いて下さい **"


loop do
  print "text>>"
  input_Text = readlines

  if input_Text.join == "" then
    puts "\n** なにも入力されていません。文字列を入力してからCtrl+Dを叩いてください。 **\n"
  else
    # ここからなにか入ってた場合の処理

    if input_Text[0] == "set_inst\n" then #インスタンス変更処理
      inst_val = change_inst()
      if inst_val != false
        system ('clear')#起動時にコマンドラインキレイキレイに

        mastodon_host = "https://#{$auth_data[inst_val]["name"]}"
        access_token = $auth_data[inst_val]["token"]

        uri = URI.parse(mastodon_host)
        http = Net::HTTP.new(uri.host, uri.port)

        http.use_ssl = true

        request = Net::HTTP::Post.new('/api/v1/statuses')
        request.add_field('Authorization', "Bearer #{access_token}")
        puts "** #{$auth_data[inst_val]["name"]}が選択されています **"

      end
    next
    end

    if input_Text[0] == "exit" || input_Text[0] == "exit\n"
      break
    end

    if input_Text[0] =~ /^.*!CW .*\n/

      cw_flag = true
      input_Text[0].slice!(/\A!CW /)
      cw_text = input_Text[0]
      input_Text.delete_at(0)

    else
      cw_flag = false
    end

    if input_Text.index { |item| item =~ /^!visiv/i } then
      visiv_row = input_Text.index { |item| item =~ /^!visiv/i }
      input_Text.delete_at(visiv_row)
      visiv_flag = true
    end

    if input_Text.join =~ /^.*!Clear.*\n/i # 入力文字列の中に!Clear(大文字小文字判別しない)が含まれた場合
      system ('clear') # トゥートごとキャンセルしてコマンドラインもきれいにする
    else
      toot_body = 'status=' + input_Text.join
      # CWの有無で分岐する
      if cw_flag == true then
        toot_body += '&spoiler_text=' + cw_text
      end

      if visiv_flag then
        visiv_set = visiv_select()
        if visiv_set == false then
          next
        end

        toot_body += '&visibility=' + visiv_select
      end

      request.body = toot_body
      response = http.request(request)

      # トゥート成功か失敗か確認する
      if response.code == '200'
        puts '** Toot Success. **'
      else
        puts '** エラー起きたかも **'
      end

    end

  end
end