
SCHEDULER.every '30m', :first_in => 0 do |job|
  send_event "food_trucks_sea", FoodTruckFetcher.new.data
end
