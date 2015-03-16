module Forecast
  class TemperatureConverter
    UNIT_STRINGS = {
      f: '°F',
      c: '°C'
    }

    def initialize(current: raise, apparent: raise, unit: raise, alt_unit: nil)
      @current = current
      @apparent = apparent
      @unit = unit
      @alt_unit = alt_unit
    end

    def current_degrees
      "#{current.round}#{UNIT_STRINGS[unit]}"
    end

    def apparent_degrees
      "#{apparent.round}#{UNIT_STRINGS[unit]}"
    end

    def alternate_degrees
      "#{alternate.round}#{UNIT_STRINGS[alt_unit]}"
    end

    def alternate?
      !!alt_unit
    end

    private

    def alternate
      case {unit => alt_unit}
      when {:f => :c}
        f_to_c(current)
      when {:c => :f}
        c_to_f(current)
      end
    end

    def f_to_c(f_deg)
      (f_deg - 32) * 5.0 / 9.0
    end

    def c_to_f(c_deg)
      (c_deg * (9.0 / 5.0)) + 32
    end

    attr_reader :current, :apparent, :unit, :alt_unit
  end
end
