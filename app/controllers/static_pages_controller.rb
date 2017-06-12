class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @shops = Shop.all
  end
  
  def create
    require 'nokogiri'
    # 検索したキーワードは保存される→カラムを追加
    # 危険な仕様の修正が残った場合は内容のみ教えて頂く
    # 最後の２回はメール配信を少しでも教えて頂く
    # 検索したキーワード毎にDMの反応を保存できる
    require 'open-uri'
    require 'cgi'
    
    keyword = CGI.escape(params[:q])
    
    app_id = ENV['YAHOO_APPLICATION_ID']
    offset = 0
    i = 0
    res_nums = 0
    total_count = 0

    loop do
      offset = 50 * i
      responces = JSON.parse open("https://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=#{app_id}&offset=#{offset}&hits=50&query=#{keyword}").read
      keys = responces['ResultSet']["0"]["Result"].keys
      keys.shift
      keys.shift
      keys.pop
      keys.each do |key|
        shop = {}
        shop.store(:url, 'http://store.shopping.yahoo.co.jp/' + responces['ResultSet']["0"]["Result"][key]['Url'].split('/')[3] + "/info.html")
        shop.store(:name, responces['ResultSet']["0"]["Result"][key]['Store']['Name'])
        Nokogiri::HTML(open(shop[:url])).xpath('//*[@id="CentInfoPage1"]/div[3]/div/table').text.match(/([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/)
        shop.store(:email, $&)
        @shop = Shop.new(shop)
        if @shop.save
          res_nums += 1
        end
        if total_count == 20 || res_nums == 10
          @shops = Shop.all
          return render 'static_pages/home'
        end
        total_count += 1
        sleep([*3..6].sample)
      end
      i += 1
    end
    
    # @address = []
    
    # @urls.each.with_index(1) do |url, i|
    #   result = Nokogiri::HTML(open(url)).xpath('//*[@id="CentInfoPage1"]/div[3]/div/table').text.match(/([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+/)
    #   @address << result
    #   sleep([*3..6].sample)
    #   puts "***#{i}回目***"
    #   puts result
    #   if i == 10
    #     return render 'static_pages/home'
    #   end
    # end
    @shops = Shop.all
    render 'static_pages/home'
  end
end
