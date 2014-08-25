require 'spec_helper'
require 'dotenv'

describe TwitterPictureFetcher , :vcr => true do
  before :each do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_OAUTH_TOKEN']
      config.access_token_secret = ENV['TWITTER_OAUTH_SECRET']
    end
    @pic_fetcher = TwitterPictureFetcher.new client

  end
  describe '.get_picture_urls_by_hashtag' do
    it 'returns a twitter api specified amount of urls, removing duplicates' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#pivotal'
      expected = [
        "http://pbs.twimg.com/media/Bvo63KoIIAArD7M.jpg",
        "http://pbs.twimg.com/media/Bvao_7_IgAEN-GO.jpg",
        "http://pbs.twimg.com/media/Bvf5d2zIEAE1Fjj.jpg",
        "http://pbs.twimg.com/media/Bvf0mcCIIAA-v1A.png",
        "http://pbs.twimg.com/media/BvfgYQ8CIAEdD6m.png",
        "http://pbs.twimg.com/media/Bvb_2XqCcAEwWip.jpg",
        "http://pbs.twimg.com/media/BvbpVaUIEAAHVPx.png",
        "http://pbs.twimg.com/media/BvbQ2WdIAAIqrUe.jpg",
        "http://pbs.twimg.com/media/Bva5cMNIgAII7OL.jpg",
        "http://pbs.twimg.com/media/BvYphshIIAADQpE.jpg",
        "http://pbs.twimg.com/media/BvWL15TIMAASHnK.jpg",
        "http://pbs.twimg.com/media/BvGUAm3IEAAKR0o.png",
      ]
      expect(urls).to eq expected

    end
    it 'returns an empty array for no results' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#noonehasusedthisyet'
      expect(urls).to eq []
    end
  end
end


