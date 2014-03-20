require 'nokogiri'
require 'open-uri'
require 'json'
class TaskController < ApplicationController


  def initialize
    @scheduler = Rufus::Scheduler.new
  end

  def stop
    if (!@scheduler.paused?)
      @scheduler.pause
    end
    end


  def resume
    if (@scheduler.paused?)
      @scheduler.resume
    end
  end

  def generateCommpony
    rel = ""
    VProvince.delete_all
    VCompany.delete_all
    doc = Nokogiri::HTML(open('http://www.vegnet.com.cn/Price'))
    doc.css('#selectArea option').each do |link|
      begin
      @pro = VProvince.new
      @pro.name = link.content
      @pro.id = link["value"]
      @pro.save
      rel += link.content
      rel += link["value"]
      uri = URI.parse('http://www.vegnet.com.cn//Market/GetMarketByAreaID?areaID='+@pro.id)
      http = Net::HTTP.new( uri.host, uri.port )
      request_obj = Net::HTTP::Get.new( uri.request_uri )
      opsdb_response = http.request( request_obj )
      if opsdb_response.body
        retJson = JSON.parse(opsdb_response.body)
        retJson.each do |com|
          company = VCompany.new
          @aa = com["Name"].to_s
          company.name= @aa
          company.id= com["MarketID"].to_i
          company.pid = @pro.id.to_i
          company.desc= com["Intro"]
          rel += company.name
          company.save
        end
      end

      rel += '\n'
      rescue =>e
          p e
      end
    end
    render :text => rel
  end
  def start
    #@scheduler.in '3s' do
    retVlave = ""
    @coms = VCompany.all
    @coms.each do |com|
      begin
        @alreadyDeal = false
        @markets = Array.new
        begin
          @dealTask = DealTask.find({"dealType" => com.id}).order_by({"dealDate" => -1}).first()
        rescue =>e1
          p "not dealTask"
        end
        # Get a Nokogiri::HTML::Document for the page we’re interested in...Date
        #doc = Nokogiri::HTML(open('http://www.vegnet.com.cn/Price/List_p2_%E7%99%BD%E8%8F%9C.html'))
        doc = Nokogiri::HTML(open('http://www.vegnet.com.cn/Price/list_ar310000.html?marketID='+com.id.to_s))


        # Do funky things with it using Nokogiri::XML::Node methods...
        ####
        # Search for nodes by css
        doc.css('.jxs_list .pri_k p').each do |link|
          @newdate = DateTime.parse(link.css('span')[0].content)
          @market = Market.new
          @market.currentDate = @newdate
          @market.name = link.css('span')[1].content
          @market.place = link.css('span')[2].css('a')[0].content
          @market.maxPrice= link.css('span')[3].content.gsub('￥', '').to_f
          @market.minPrice = link.css('span')[4].content.gsub('￥', '').to_f
          @market.avgPrice = link.css('span')[5].content.gsub('￥', '').to_f
          @market.unit = link.css('span')[6].content
          @markets = @markets+[@market]
          if(!@dealTask || @dealTask.dealType != com.id)
            @dealTask = DealTask.new
            @dealTask.dealDate = @newdate
            @dealTask.dealType = com.id.to_s
            @dealTask.save
          elsif (@newdate < @dealTask.dealDate)
            @alreadyDeal = true
            break
          end
          @market.save
          retVlave += @market.name
        end
      rescue => e
        retVlave += e.to_s
      end
    end
    #end

    #@scheduler.join
    render :text => retVlave
  end

  def delete
    #if !@scheduler.down?
    #  @scheduler.shutdown
    #end
  end
end
