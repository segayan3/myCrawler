class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @urls = []
  end
  
  def create
    # URLを重複なく新規で100件取得する
    # 検索キーワードを指定できる
    # 検索したキーワードは保存される
    # 検索したキーワード毎にDMの反応を保存できる
    require 'open-uri'
    
    app_id = 'dj0zaiZpPXFkdlVWczZkV0RMayZzPWNvbnN1bWVyc2VjcmV0Jng9ODQ-'
    @urls = []
    responces = JSON.parse open("https://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=#{app_id}&query=%E6%A5%BD%E5%99%A8").read
    keys = responces['ResultSet']["0"]["Result"].keys
    keys.shift
    keys.shift
    keys.pop
    keys.each do |key|
      @urls << responces['ResultSet']["0"]["Result"][key]['Url'].gsub(/\/\w+\.html\Z/, '/info.html')
    end
    @urls = @urls.uniq
    render 'static_pages/home'
  end
end
