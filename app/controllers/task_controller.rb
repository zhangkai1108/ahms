require 'nokogiri'
require 'open-uri'
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

  def start
    #@scheduler.in '3s' do
      begin
        @alreadyDeal = false
        @markets = Array.new
        begin
          @dealTask = DealTask.find({"dealType" => "name"}).order_by({"dealDate" => -1}).first()
        rescue =>e1
          p "not dealTask"
        end
        # Get a Nokogiri::HTML::Document for the page we’re interested in...Date
        doc = Nokogiri::HTML(open('http://www.vegnet.com.cn/Price/List_p2_%E7%99%BD%E8%8F%9C.html'))
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
          if(!@dealTask)
            @dealTask = DealTask.new
            @dealTask.dealDate = @newdate
            @dealTask.dealType = 1
            @dealTask.save
          else  (@newdate <= @dealTask.dealDate)
            @alreadyDeal = true
            break
          end
          @market.save
        end
      rescue => e
        p e
      end

    #end
    #@scheduler.join
    render :text => "test,kkkkkkkkkkkkkkkkkkkkkk"
  end

  def delete
    #if !@scheduler.down?
    #  @scheduler.shutdown
    #end
  end
end
