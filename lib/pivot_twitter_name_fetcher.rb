require 'json'

class PivotTwitterNameFetcher
  attr_accessor :pivots_url

  def initialize credentials
    self.pivots_url = "https://pivotalpivots2.herokuapp.com/api/users.json?email=#{credentials[:email]}&authentication_token=#{credentials[:authentication_token]}"
  end
  def get_twitter_names
    result = JSON.parse(Net::HTTP.get(URI(self.pivots_url)))
    result.map{|x| x["twitter"]}.compact.delete_if(&:empty?)
  end
end
