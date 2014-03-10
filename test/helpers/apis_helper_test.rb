require 'nokogiri'
require 'open-uri'

p Date.strptime('[03-02-2001]', '[%d-%m-%Y]')

# Get a Nokogiri::HTML::Document for the page we’re interested in...

doc = Nokogiri::HTML(open('http://www.vegnet.com.cn/Price/List_p2_%E7%99%BD%E8%8F%9C.html'))
# Do funky things with it using Nokogiri::XML::Node methods...
####
# Search for nodes by css
doc.css('.jxs_list .pri_k p').each do |link|
  p link.css('span')[0].content
  p link.css('span')[1].content
  p link.css('span')[2].css('a')[0].content
  p link.css('span')[3].content.gsub('￥','').to_f
  p link.css('span')[4].content.gsub('￥','').to_f
  p link.css('span')[5].content.gsub('￥','').to_f
  p link.css('span')[6].content
end
