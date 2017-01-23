require 'spec_helper'
require 'webmock'
include WebMock::API

describe TextMessageFetcher do
  let(:pivot_texts_url) {'http://pivot-texts/texts/all'}
  let(:basic_username) {'test-un'}
  let(:basic_password) {'test-pw'}

  before(:each) do
    stub_request(:get, "http://pivot-texts/texts/all").to_return(:body => File.read('spec/fixtures/pivot_texts.json'))
  end

  describe '#[]' do
    let(:fetcher) { TextMessageFetcher.new(pivot_texts_url, basic_username, basic_password) }

    it 'returns all text messages' do
      texts = fetcher.get
      expect(texts.size).to eq 2

      first_text = texts.first
      expect(first_text["pivotId"]).to eq 1
      expect(first_text["pivotLocation"]).to eq "Boulder"
      expect(first_text["pivotFirstName"]).to eq "Jane"
      expect(first_text["pivotLastName"]).to eq "Smith"
      expect(first_text["message"]).to eq "Hi pivots"
      expect(first_text["receivedAt"]).to eq 1435347799
    end
  end
end
