require 'twitter'
require 'dotenv'

Dotenv.load

DefaultClient = Twitter::REST::Client.new do |config|
  config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
  config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
  config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
  config.access_token_secret = ENV['TWITTER_OAUTH_SECRET']
end

class TwitterPictureFetcher
  attr_accessor :client
  def initialize client=DefaultClient
    self.client = client
  end
  def get_picture_urls_by_hashtag hashtag
    self.client.search("#{hashtag} filter:images", :result_type => "recent").collect {|x| x.media.collect {|y| y.url.to_s}}.flatten
  end
end

