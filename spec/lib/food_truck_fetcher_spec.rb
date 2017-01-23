require 'spec_helper'

describe FoodTruckFetcher do
  let(:fetcher) { FoodTruckFetcher.new }

  before do
    occidental_url = 'http://www.seattlefoodtruck.com/schedule/occidental-park-food-truck-pod'
    stub_request(:get, occidental_url).to_return(body: File.read('spec/fixtures/food_trucks_seattle.html'))
  end

  it 'gets todays food trucks' do
    Timecop.freeze(DateTime.new(2017, 1, 24, 13, 59, 0, Rational(-8, 24))) do
      expect(fetcher.data).to eq({
        title: "Tuesday's Food Trucks",
        trucks: [
          { name: 'Beez Kneez Gourmet Sausages', type: 'Hot Dogs' },
          { name: 'Off The Rez', type: 'Burgers / Native American' },
          { name: "Sam Choy's Poke To The Max", type: 'Hawaiian' },
          { name: 'Snout & Co.', type: 'Cuban / Southern' }
        ]
      })
    end
  end

  it 'gets tomorrows food trucks after 2pm Pacific' do
    Timecop.freeze(DateTime.new(2017, 1, 24, 14, 01, 0, Rational(-8, 24))) do
      expect(fetcher.data).to eq({
        title: "Wednesday's Food Trucks",
        trucks: [
          { name: "Delfino's Chicago Pizza", type: 'Pizza' },
          { name: 'El Cabrito Oaxaca', type: 'Mexican' },
          { name: 'NOSH', type: 'English' },
          { name: 'Seattle Chicken Over Rice', type: 'Mediterranean' }
        ]
      })
    end
  end
end
