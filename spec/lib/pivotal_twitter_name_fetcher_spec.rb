require 'spec_helper'

describe PivotalTwitterNameFetcher , :vcr => true do
  before :each do
    credentials = {:authentication_token => 'redacted', :email => 'redacted'}
    @name_fetcher = PivotalTwitterNameFetcher.new credentials

  end
  describe '.get_twitter_names' do
    it 'returns a list of twitter names for all pivots who have provided their name' do
      names = @name_fetcher.get_twitter_names
      expect(names[0]).to eq "azzamallow"
      expect(names[-1]).to eq "spyyddir"
    end
    it 'contains no nil or empty string values' do
      names = @name_fetcher.get_twitter_names
      empty_values = names.select {|x| x == nil ||  x == ""}
      expect(empty_values.count).to eq 0
    end
  end
end


