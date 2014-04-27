require 'net/https'
require 'json'
require 'dotenv'

Dotenv.load

# Forecast API Key from https://developer.forecast.io
forecast_api_key = ENV['FORECAST_API_KEY']

SCHEDULER.every '5m', :first_in => 0 do |job|
  location_forecasts = ForecastFetcher.new(forecast_api_key).data
  location_forecasts.each_pair do |location, data|
    send_event "forecast-#{location}", data
  end
end

