require 'spec_helper'
require 'dotenv'
require 'webmock'
include WebMock::API

describe PivotTwitterNameFetcher do
  before :each do
    credentials = {:authentication_token => (ENV['PIVOTS_AUTH_TOKEN'] || 'PIVOTS_AUTH_TOKEN'), :email => (ENV['PIVOTS_EMAIL'] || 'PIVOTS_EMAIL')}
    @name_fetcher = PivotTwitterNameFetcher.new credentials
    stub_request(:get, @name_fetcher.pivots_url).to_return(:body => File.read('spec/fixtures/pivots_new_and_old_users.json'))
  end
  describe '.get_twitter_names' do
    it 'returns a list of downcased twitter names for all pivots who have provided their name' do
      names = @name_fetcher.get_twitter_names
      expect(names[0]).to eq "ajarecki"
      expect(names[-1]).to eq "sblarg7"
    end

    it 'contains no nil or empty string values' do
      names = @name_fetcher.get_twitter_names
      empty_values = names.select { |x| x == nil || x == "" }
      expect(empty_values.count).to eq 0
    end

    context 'with improper credentials' do
      before(:each) do
        @name_fetcher = PivotTwitterNameFetcher.new({:authentication_token => 'no', :email => 'way'})
        stub_request(:get, @name_fetcher.pivots_url).to_return(:body => '{"error": "You need to sign in or sign up before continuing."}')
      end
      it 'raises an exception' do
        expect do
          @name_fetcher.get_twitter_names
        end.to raise_error('You need to sign in or sign up before continuing.')
      end
    end

  end
end


