require 'nokogiri'
require 'open-uri'
class TaskController < ApplicationController

  @scheduler = Rufus::Scheduler.new
  def stop
    if (!@scheduler.paused?)
      @scheduler.pause
    end
  end

  def resume
    if (@@scheduler.paused?)
      @scheduler.resume
    end
  end

  def start
    @scheduler.every '3h' do

      begin
        @alreadyDeal = false
        @markets = Array.new
        @dealTask = DealTask.find({"dealType"=>"name"}).order_by({"dealDate"=>-1}).first()
        # Get a Nokogiri::HTML::Document for the page we’re interested in...
        doc = Nokogiri::HTML(open('http://www.vegnet.com.cn/Price/List_p2_白菜.html'))
        # Do funky things with it using Nokogiri::XML::Node methods...
        ####
        # Search for nodes by css
        doc.css('.jxs_list .pri_k p').each do |link|
          @newdate = Date.strptime(link.css('span')[0].content, '[%d-%m-%Y]')
          @market = Market.new
          @market.currentDate = @newdate
          @market.name = link.css('span')[1].content
          @market.place = link.css('span')[2].css('a')[0].content
          @market.maxPrice= link.css('span')[3].content.gsub('￥', '').to_f
          @market.minPrice = link.css('span')[4].content.gsub('￥', '').to_f
          @market.avgPrice = link.css('span')[5].content.gsub('￥', '').to_f
          @market.unit = link.css('span')[6].content
          @markets = @markets+[@market]
          if(@newdate <= @dealTask.dealDate)
            @alreadyDeal = true
            break
          end
          @market.save
        end
      rescue => e
        logger.debug("syn data error" +e);
      end

    end
  end

  def delete
    if !@scheduler.down?
      @scheduler.shutdown
    end
  end
end
