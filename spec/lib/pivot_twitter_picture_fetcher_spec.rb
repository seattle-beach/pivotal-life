require 'spec_helper'

describe PivotTwitterPictureFetcher do
  let(:twitter_results) { [
    {url: "http://pbs.twimg.com/media/Bvo63KoIIAArD7M.jpg", user_name: "beyonce"},
    {url: "http://pbs.twimg.com/media/stuff.jpg", user_name: "miked"},
    {url: "http://pbs.twimg.com/media/cooler_stuff.jpg", user_name: "davidm"},
  ] }

  let(:pivot_twitter_names) { ["miked", "davidm", "timj" ] }

  let(:expected_pivot_picture_urls_results) { [
    "http://pbs.twimg.com/media/stuff.jpg",
    "http://pbs.twimg.com/media/cooler_stuff.jpg"
  ] }

  before :each do
    @name_fetcher = double(:pivot_twitter_name_fetcher)
    @picture_fetcher = double(:twitter_picture_fetcher)
    @pivot_twitter_picture_fetcher = PivotTwitterPictureFetcher.new(@name_fetcher, @picture_fetcher)
  end

  describe '.get_pivot_picture_urls_by_hashtag' do
    it 'only includes picture urls from pivots' do
      allow(@name_fetcher).to receive(:get_twitter_names).and_return(pivot_twitter_names)
      allow(@picture_fetcher).to receive(:get_picture_urls_by_hashtag).with('pivotallife').and_return(twitter_results)
      expect(@pivot_twitter_picture_fetcher.get_pivot_picture_urls_by_hashtag('pivotallife')).to eq(expected_pivot_picture_urls_results)
    end
  end
end


