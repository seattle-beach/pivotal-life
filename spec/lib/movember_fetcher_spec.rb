require 'rspec'

require_relative '../../lib/movember_fetcher'

describe MovemberFetcher do
  describe "#fetch" do
    let(:page_source) { File.open('spec/fixtures/movember_page_source.html') }
    let(:fetcher) { MovemberFetcher.new(1712277, page_source) }

    it "returns the correct team name" do
      expect(fetcher.fetch[:label]).to eq "Pivotal - New York City"
    end

    it "returns the correct team donation total" do
      expect(fetcher.fetch[:value]).to eq "$3,024"
    end
  end
end
