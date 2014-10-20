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

      expected = [{:url => "http://pbs.twimg.com/media/Bv25la1CcAEFltV.jpg", :user_name => "heikal_amr"},
                  {:url => "http://pbs.twimg.com/media/Bv2zDNaCIAEjGt-.jpg", :user_name => "teazyfresco"},
                  {:url => "http://pbs.twimg.com/media/Bv00tE0IAAApwNt.jpg", :user_name => "atoms2bits"},
                  {:url => "http://pbs.twimg.com/media/Bvo63KoIIAArD7M.jpg", :user_name => "peterboaventura"},
                  {:url => "http://pbs.twimg.com/media/BvxCeP8IcAA0rRL.jpg", :user_name => "angellmclovin"},
                  {:url => "http://pbs.twimg.com/media/BvxDK8nIIAA72VF.jpg", :user_name => "9acino_"},
                  {:url => "http://pbs.twimg.com/media/BvxCeP8IcAA0rRL.jpg", :user_name => "pivotgang"},
                  {:url => "http://pbs.twimg.com/media/BuabBEhIYAAFYKb.jpg", :user_name => "asimjalis"},
                  {:url => "http://pbs.twimg.com/media/Bvo63KoIIAArD7M.jpg", :user_name => "markjan4"},
                  {:url => "http://pbs.twimg.com/media/Bvo63KoIIAArD7M.jpg", :user_name => "wbruninx"},
                  {:url => "http://pbs.twimg.com/media/Bvao_7_IgAEN-GO.jpg", :user_name => "badnima"},
                  {:url => "http://pbs.twimg.com/media/Bvao_7_IgAEN-GO.jpg", :user_name => "rippmn"},
                  {:url => "http://pbs.twimg.com/media/Bvf5d2zIEAE1Fjj.jpg", :user_name => "atoms2bits"},
                  {:url => "http://pbs.twimg.com/media/Bvf0mcCIIAA-v1A.png", :user_name => "atoms2bits"},
                  {:url => "http://pbs.twimg.com/media/BvfgYQ8CIAEdD6m.png", :user_name => "abelimited"},
                  {:url => "http://pbs.twimg.com/media/Bvb_2XqCcAEwWip.jpg", :user_name => "boogabee"},
                  {:url => "http://pbs.twimg.com/media/BvbpVaUIEAAHVPx.png", :user_name => "bigdatajoerossi"},
                  {:url => "http://pbs.twimg.com/media/BvbQ2WdIAAIqrUe.jpg", :user_name => "affanato"},
                  {:url => "http://pbs.twimg.com/media/Bva5cMNIgAII7OL.jpg", :user_name => "stevenbbecker"},
                  {:url => "http://pbs.twimg.com/media/Bva5cMNIgAII7OL.jpg", :user_name => "boogabee"},
                  {:url => "http://pbs.twimg.com/media/Bvao_7_IgAEN-GO.jpg", :user_name => "wattersjames"},
                  {:url => "http://pbs.twimg.com/media/Bvao_7_IgAEN-GO.jpg", :user_name => "mstine"},
                  {:url => "http://pbs.twimg.com/media/Bvao_7_IgAEN-GO.jpg", :user_name => "boogabee"},
                  {:url => "http://pbs.twimg.com/media/BvYphshIIAADQpE.jpg", :user_name => "atoms2bits"},
                  {:url => "http://pbs.twimg.com/media/BvWL15TIMAASHnK.jpg", :user_name => "_tweetsome"}
      ]

      expect(urls).to eq expected
    end

    it 'returns an empty array for no results' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#noonehasusedthisyet'
      expect(urls).to eq []
    end
  end
end


