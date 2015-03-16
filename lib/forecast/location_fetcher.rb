module Forecast
  class LocationFetcher
    def initialize(api_key)
      @api_key = api_key
      @http = Net::HTTP.new("api.forecast.io", 443)
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    end

    def location_data(location)
      lat = location[:lat]
      lon = location[:lon]
      units = location[:units]

      response = http.request(Net::HTTP::Get.new("/forecast/#{api_key}/#{lat},#{lon}?units=#{units}"))
      JSON.parse(response.body)
    end

    private

    attr_reader :api_key, :http
  end
end
