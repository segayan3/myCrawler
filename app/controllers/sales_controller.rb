class SalesController < ApplicationController
  require 'open-uri'
  #require 'JSON'
  require 'nokogiri'
  
  # ヤフーショッピングのアプリケーションID
  y_app_id = 'dj0zaiZpPXFkdlVWczZkV0RMayZzPWNvbnN1bWVyc2VjcmV0Jng9ODQ-'

  def new
    @sale = Sale.new
  end
  
  def create
    res = JSON.parse open('https://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch?appid=y_app_id&query=%E6%A5%BD%E5%99%A8').read
    #@res_url = []
    # res.each{|key, value|
    #   if(key == 'ResultSet')
    #     res['ResultSet'].each{|key, value|
    #       if(key == "0")
    #         res['ResultSet']["0"].each{|key, value|
    #           if(key == "0")
    #             @res_url =  res['ResultSet']["0"]
    #             # res['ResultSet']['0']['0'].each{|key, value|
    #             # @res_url[key] = value
    #             #   # if(key == "Url")
    #             #   #   @res_url = value
    #             #   # end
    #             # }
    #           end
    #         }
    #       end
    #     }
    #   end
    # }
    
    # # カテゴリ情報を取得
    # cate_id_api = "http://shopping.yahooapis.jp/ShoppingWebService/V1/categorySearch?appid=y_app_id&category_id=1"
    
    # cate_xml = Nokogiri::XML(open(cate_id_api), nil, "utf-8")

    # @cate_ids = []
    # cate_xml.xpath('/children/child').each do |child|
    #   @cate_ids.push(child["id"])
    # end
    
    
    #url = "http://shopping.yahooapis.jp/ShoppingWebService/V1/itemSearch?appid=y_app_id"
    #@doc = Nokogiri::HTML(open(url), nil, "utf-8")
    
  end
end
