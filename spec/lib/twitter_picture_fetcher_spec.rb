require 'spec_helper'
require 'dotenv'

describe TwitterPictureFetcher, :vcr => true do
  before :each do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY'] || 'TWITTER_CONSUMER_KEY'
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET'] || 'TWITTER_CONSUMER_SECRET'
      config.access_token = ENV['TWITTER_OAUTH_TOKEN'] || 'TWITTER_OAUTH_TOKEN'
      config.access_token_secret = ENV['TWITTER_OAUTH_SECRET'] || 'TWITTER_OAUTH_SECRET'
    end
    @pic_fetcher = TwitterPictureFetcher.new client

  end
  describe '.get_picture_urls_by_hashtag' do
    it 'returns a twitter api specified amount of urls, removing duplicates and downcasing usernames' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#pivotal'

      expected = [
        {url: "http://pbs.twimg.com/media/CZAT0SsUQAAo4wu.png", user_name: "sarge_siddiqui"},
        {url: "http://pbs.twimg.com/media/CYwcN-IWwAACWYc.png", user_name: "vmware_be"},
        {url: "http://pbs.twimg.com/media/CY3kNZMWAAAI60W.png", user_name: "dinkoeror"},
        {url: "http://pbs.twimg.com/media/CY3kNZMWAAAI60W.png", user_name: "emcacademics"},
        {url: "http://pbs.twimg.com/media/CYy3RD5VAAARHSn.jpg", user_name: "the_sales_guy"},
        {url: "http://pbs.twimg.com/media/CYx3zEzWAAA7bF_.jpg", user_name: "insightbrief"},
        {url: "http://pbs.twimg.com/media/CYwXO6OUsAAtMy2.png", user_name: "timbukonesens"},
        {url: "http://pbs.twimg.com/media/CYwT-dMWMAAq7Y-.jpg", user_name: "asfiyahussain"},
        {url: "http://pbs.twimg.com/media/CYs8LKUWYAADxKo.jpg", user_name: "insightbrief"},
        {url: "http://pbs.twimg.com/media/CYqgQ9cVAAApMRq.jpg", user_name: "the_sales_guy"},
        {url: "http://pbs.twimg.com/media/CYqCl3tUwAEdjsb.jpg", user_name: "coolbox_studio"},
        {url: "http://pbs.twimg.com/media/CYp7np8WYAA-i2Q.jpg", user_name: "lashawndobbs"},
        {url: "http://pbs.twimg.com/media/CYoJzY1U0AESMgn.jpg", user_name: "faizana_samreen"},
        {url: "http://pbs.twimg.com/media/CYnWOCwWcAAKkJb.jpg", user_name: "rgamal89"},
        {url: "http://pbs.twimg.com/media/CYmxlDbWsAMIlAY.jpg", user_name: "nehasoni0306"},
        {url: "http://pbs.twimg.com/media/CYmubqGUwAEoBC_.jpg", user_name: "happydespitecp"},
        {url: "http://pbs.twimg.com/media/CYk_JRdWYAEaPUC.jpg", user_name: "varunsharma14"},
        {url: "http://pbs.twimg.com/media/CYjD-GaWMAExUcw.jpg", user_name: "the_sales_guy"},
        {url: "http://pbs.twimg.com/media/CYi8q7UWYAE_6ml.jpg", user_name: "manojbelhi"},
        {url: "http://pbs.twimg.com/media/CYiooKiW8AA2mCx.jpg", user_name: "insightbrief"},
        {url: "http://pbs.twimg.com/media/CYiLZ7BWwAEjG37.jpg", user_name: "the_sales_guy"},
        {url: "http://pbs.twimg.com/media/CYh0qpGUQAEmZtJ.jpg", user_name: "elainebeare"},
        {url: "http://pbs.twimg.com/media/CYeZ85tUkAEPpPY.png", user_name: "dbaker007"},
        {url: "http://pbs.twimg.com/media/CYX9x7kUoAACkiQ.jpg", user_name: "insightbrief"},
        {url: "http://pbs.twimg.com/media/CYTfRszU0AAifsb.jpg", user_name: "pivotalphysio"}
      ]

      expect(urls).to eq expected
    end

    it 'returns an empty array for no results' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#noonehasusedthisyet'
      expect(urls).to eq []
    end

    # The following two tweets appear in the recorded cassette data
    # Because they are retweets, get_picture_urls_by_hashtag should not return them
    # {url: "http://pbs.twimg.com/media/CRr_HUSUsAAlD3T.jpg", user_name: "applecinnam0n"}
    # {url: "http://pbs.twimg.com/media/CYyRQ1kWMAANoaN.jpg", user_name: "spilth"}
    # {url: "http://pbs.twimg.com/media/CYkr_hCU0AAKX-E.jpg", user_name: "leckylao"}
    # {url: "http://pbs.twimg.com/media/CYkr_hCU0AAKX-E.jpg", user_name: "shaunnorris"}
    # {url: "http://pbs.twimg.com/media/CYkr_hCU0AAKX-E.jpg", user_name: "simon_elisha"}

    it 'excludes retweets' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#pivotallife'
      expected = [
        {url: "http://pbs.twimg.com/media/CZAwH19WcAA1hjc.jpg", user_name: "spilth"},
        {url: "http://pbs.twimg.com/media/CZAqDg1W8AQ8Gh9.jpg", user_name: "dannyzen"},
        {url: "http://pbs.twimg.com/media/CZApZPZWkAAu7Bb.jpg", user_name: "mike_kenyon"},
        {url: "http://pbs.twimg.com/media/CY8tDs6WwAEBog0.jpg", user_name: "mike_kenyon"},
        {url: "http://pbs.twimg.com/media/CYyrry_UkAUGEgL.jpg", user_name: "spilth"},
        {url: "http://pbs.twimg.com/media/CYyf3kMU0AE8nXU.jpg", user_name: "applecinnam0n"},
        {url: "http://pbs.twimg.com/media/CYyRQ1kWMAANoaN.jpg", user_name: "applecinnam0n"},
        {url: "http://pbs.twimg.com/media/CYpu9UpUwAArhCm.jpg", user_name: "usedrecently"},
        {url: "http://pbs.twimg.com/media/CYkr_hCU0AAKX-E.jpg", user_name: "lozcrowther"}
      ]

      expect(urls).to eq expected
    end
  end
end


