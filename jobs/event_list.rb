#!/usr/bin/env ruby

offices_yaml = File.read('offices.yml')
offices = Offices.load(offices_yaml)


@events = CalendarFetcher.new()

SCHEDULER.every '1m', :first_in => 0 do |job|
  offices.each do |office|
    if office.has_config?("calendar")

      @events = CalendarFetcher.new() if @events.nil?
      @events.get_events(office.config['calendar']['id'])
      event_fetcher = EventFetcher.new(@events.data)
      send_event("calendar_events_#{office.code}", event_fetcher.fetch_events(7))

    end
  end
end

