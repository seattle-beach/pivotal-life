module Forecast
  class LocationResponseFormatter
    def initialize(location, response)
      @location = location
      @response = response
    end

    def data
      temperature_formatter = Forecast::TemperatureConverter.new(current: response["currently"]["temperature"],
                                                                  apparent: response["currently"]["apparentTemperature"],
                                                                  unit: location[:temp_unit],
                                                                  alt_unit: location[:alt_temp_unit])
      data = {
        current_temp: temperature_formatter.current_degrees,
        apparent_temp: temperature_formatter.apparent_degrees,
        current_icon: response["currently"]["icon"],
        current_desc: response["currently"]["summary"],
        later_desc: response["hourly"]["summary"],
        later_icon: response["hourly"]["icon"]
      }

      if temperature_formatter.alternate?
        data.merge!({
          alternate_temp:  temperature_formatter.alternate_degrees
        })
      end

      if response["minutely"]  # sometimes this is missing from the response.  I don't know why
        data.merge!({
          next_desc: response["minutely"]["summary"],
          next_icon: response["minutely"]["icon"]
        })
      else
        puts "Did not get minutely response data again"
        data.merge!({
          next_desc: "No data",
          next_icon:  ""
        })
      end

      data
    end

    private

    attr_reader :location, :response
  end
end
