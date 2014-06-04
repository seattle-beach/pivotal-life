require 'spec_helper'

describe CitibikeFetcher, :vcr => true do
  describe '.find' do
    let(:lat_lon) { [40.74033720000001, -73.9951462] }
    let(:radius) { 0.5 }
    let(:returned_stations) { CitibikeFetcher.find(lat_lon, radius) }

    it 'returns the n closest stations' do
      returned_stations.map! { |station| station[:id] }
      expect(returned_stations).to include 168
      expect(returned_stations).not_to include 540
    end
  end
end


