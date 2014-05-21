#!/usr/bin/env ruby

offices_yaml = File.read('offices.yml')
offices = Offices.load(offices_yaml)

SCHEDULER.every '1m', :first_in => 0 do |job|
  offices.each do |office|
    if office.has_config?("calendar")
      events = CalendarFetcher.new(office.config["calendar"]["url"]).data
      events.sort! { |a, b| a[:when_start_raw] <=> b[:when_start_raw] }
      send_event("calendar_events_#{office.code}", {events: events})
    end
  end
end

