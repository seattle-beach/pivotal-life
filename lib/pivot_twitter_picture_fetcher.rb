class PivotTwitterPictureFetcher
  def initialize user_name_fetcher, twitter_picture_fetcher
    @user_name_fetcher = user_name_fetcher
    @twitter_picture_fetcher = twitter_picture_fetcher
  end

  def get_pivot_picture_urls_by_hashtag hashtag
    twitter_picture_results = @twitter_picture_fetcher.get_picture_urls_by_hashtag hashtag
    user_name_results = @user_name_fetcher.get_twitter_names
    twitter_picture_results.select do |kv|
      not user_name_results.find{|x| x == kv[:user_name]}.nil?
    end
  end
end
