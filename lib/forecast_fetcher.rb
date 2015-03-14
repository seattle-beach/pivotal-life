class ForecastFetcher
  # Unit Format
  # "us" - U.S. Imperial
  # "si" - International System of Units
  # "uk" - SI w. windSpeed in mph
  DEFAULT_LOCATIONS = {
    sf: { lat: 40.740673, lon: -73.994808, units: 'us' },
    pa: { lat: 37.394555, lon: -122.148039, units: 'us' },
    london: { lat: 51.5072, lon: 0.1275, units: 'uk' },
    nyc: { lat: 40.740673, lon: -73.994808, units: 'us', alt_temp_method: :f_to_c },
    to: { lat: 43.649932, lon: -79.375756, units: 'si'}
  }

  def initialize(api_key, locations = DEFAULT_LOCATIONS)
    @api_key = api_key
    @locations = locations
    @location_fetcher = Forecast::LocationFetcher.new(api_key)
  end

  def data
    memo = {}
    locations.each_pair do |key, location|
      memo[key]= location_fetcher.location_data(location)
    end
    memo
  end

  private

  attr_reader :api_key, :locations, :location_fetcher
end
