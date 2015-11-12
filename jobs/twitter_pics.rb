require 'cgi'
require 'twitter'
require 'dotenv'

Dotenv.load

SCHEDULER.every '10m', :first_in => 0 do |job|
  tweets = []
  begin
    hashtag = ENV['TWITTER_PICTURE_HASHTAG'] || "PivotalLife"
    fetcher = PivotTwitterPictureFetcher.new(PivotTwitterNameFetcher.new(DefaultCredentials), TwitterPictureFetcher.new(DefaultClient))
    tweets = fetcher.get_pivot_picture_urls_by_hashtag(hashtag)
  rescue Twitter::Error
    puts "\e[33mFor the twitter widget to work, you need to put in your twitter API keys in the jobs/twitter.rb file.\e[0m"
  ensure
    send_event('twitter_pictures', tweets: tweets)
  end
end
