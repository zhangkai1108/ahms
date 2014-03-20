require 'json'
url = "http://www.vegnet.com.cn//Market/GetMarketByAreaID?areaID=310000"
begin
  timeout(10, Errno::ETIMEDOUT) {
    uri = URI.parse(url)
    http = Net::HTTP.new( uri.host, uri.port )
    request_obj = Net::HTTP::Get.new( uri.request_uri )
    opsdb_response = http.request( request_obj )
    res = opsdb_response.body
    aa = JSON.parse(res)
    p aa
  }
rescue => ex
  p ex.message
end