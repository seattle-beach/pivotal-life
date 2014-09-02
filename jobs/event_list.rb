#!/usr/bin/env ruby

offices_yaml = File.read('offices.yml')
offices = Offices.load(offices_yaml)

SCHEDULER.every '1m', :first_in => 0 do |job|
  offices.each do |office|
    if office.has_config?("calendar")
      calendar_fetcher = CalendarFetcher.new(office.config["calendar"]["url"])
      event_fetcher = EventFetcher.new(calendar_fetcher.data)
      send_event("calendar_events_#{office.code}", event_fetcher.fetch_events(7))
    end
  end
end

