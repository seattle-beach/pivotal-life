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
      alt_temp_method = location[:alt_temp_method]

      response = http.request(Net::HTTP::Get.new("/forecast/#{api_key}/#{lat},#{lon}?units=#{units}"))
      forecast = JSON.parse(response.body)

      current_temp = forecast["currently"]["temperature"].round

      data = {
        current_temp:  current_temp,
        current_icon: forecast["currently"]["icon"],
        current_desc: forecast["currently"]["summary"],
        apparent_temp: forecast["currently"]["apparentTemperature"].round,
        later_desc: forecast["hourly"]["summary"],
        later_icon: forecast["hourly"]["icon"]
      }

      if alt_temp_method
        converter = Forecast::TemperatureConverter.new(current_temp)
        alternate_temp = converter.public_send(alt_temp_method).round

        data.merge!({
          alternate_temp:  alternate_temp
        })
      end

      if forecast["minutely"]  # sometimes this is missing from the response.  I don't know why
        data.merge!({
          next_desc: forecast["minutely"]["summary"],
          next_icon: forecast["minutely"]["icon"]
        })
      else
        puts "Did not get minutely forecast data again"
        data.merge!({
          next_desc: "No data",
          next_icon:  ""
        })
      end
      data
    end

    private

    attr_reader :api_key, :http

  end
end
