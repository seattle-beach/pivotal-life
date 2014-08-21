require 'spec_helper'

describe TwitterPictureFetcher , :vcr => true do
  before :each do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'redacted'
      config.consumer_secret     = 'redacted'
      config.access_token        = 'redacted'
      config.access_token_secret = 'redacted'
    end
    @pic_fetcher = TwitterPictureFetcher.new client
  end
  describe '.get_picture_urls_by_hashtag' do
    it 'returns a twitter api specified amount of urls' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#pivotal'
      expected = [
        "http://t.co/B9OYsh0Ly1",
        "http://t.co/B9OYsh0Ly1",
        "http://t.co/NpV8jdiiFG",
        "http://t.co/SQVPLHNbVa",
        "http://t.co/342BbwknbD",
        "http://t.co/UvFza7m6xc",
        "http://t.co/HSFo5kFHmI",
        "http://t.co/9B7j8YQJuX",
        "http://t.co/WG5vaYOzTs",
        "http://t.co/WG5vaYOzTs",
        "http://t.co/B9OYsh0Ly1",
        "http://t.co/B9OYsh0Ly1",
        "http://t.co/B9OYsh0Ly1",
        "http://t.co/W7gmkIy8YX",
        "http://t.co/3F8FT8WoAK",
        "http://t.co/GUy8WzrNTI",
        "http://t.co/GUy8WzrNTI"
      ]
      expect(urls).to eq expected
    end
    it 'returns an empty array for no results' do
      urls = @pic_fetcher.get_picture_urls_by_hashtag '#noonehasusedthisyet'
      expect(urls).to eq []
    end
  end
end


