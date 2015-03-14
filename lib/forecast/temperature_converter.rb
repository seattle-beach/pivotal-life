module Forecast
  class TemperatureConverter
    def initialize(temperature)
      @temperature = temperature
    end

    def f_to_c
      (@temperature - 32) * 5.0 / 9.0
    end

    def c_to_f
      (@temperature * (9.0 / 5.0)) + 32
    end
  end
end
