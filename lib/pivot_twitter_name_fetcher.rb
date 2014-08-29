require 'json'
require 'dotenv'

Dotenv.load

DefaultCredentials = {:authentication_token => (ENV['PIVOTS_AUTH_TOKEN']) , :email => (ENV['PIVOTS_EMAIL'])}

class PivotTwitterNameFetcher
  attr_accessor :pivots_url

  def initialize credentials
    self.pivots_url = "https://pivotalpivots2.herokuapp.com/api/users.json?email=#{credentials[:email]}&authentication_token=#{credentials[:authentication_token]}"
  end

  def get_twitter_names
    result = JSON.parse(Net::HTTP.get(URI(self.pivots_url)))

    if result.is_a?(Hash) and result['error']
      raise result['error']
    end

    result.map{|x| x["twitter"]}.compact.delete_if(&:empty?)
  end
end
