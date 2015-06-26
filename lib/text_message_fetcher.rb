require 'json'
require 'open-uri'

class TextMessageFetcher
  def initialize(url, basic_username, basic_password)
    @uri = URI.parse(url)
    @req = Net::HTTP::Get.new(@uri)
    @req.basic_auth(basic_username, basic_password)
  end

  def get
    res = Net::HTTP.start(@uri.hostname, @uri.port, use_ssl: @uri.scheme == 'https') { |http|
      http.request(@req)
    }

    return JSON.parse(res.body)
  end
end

