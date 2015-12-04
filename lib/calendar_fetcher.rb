require 'date'
require 'open-uri'
require 'nokogiri'
require 'cgi'

require 'googleauth'
require 'google/apis/calendar_v3'

class CalendarFetcher


  MAX_EVENTS_TO_GET = 7

  attr_reader :client

  def initialize(name='')
    @name = name
    @@Calendar = Google::Apis::CalendarV3
    scopes = [@@Calendar::AUTH_CALENDAR_READONLY]
    @client = @@Calendar::CalendarService.new

    #set authorization info and also actually try connecting
    @client.authorization = Google::Auth.get_application_default(scopes)
  end

  def get_events(cal_id)
    events = []

    @EventClass = Event.new
    min = Time.now.iso8601

    results = client.list_events(cal_id, max_results: MAX_EVENTS_TO_GET, single_events: true,
                                 order_by: 'startTime', time_min: min)

    results.items.each do |event|
      title = event.summary
      content = event.description
      when_node_start = event.start.date || event.start.date_time
      when_node_end = event.end.date || event.end.date_time
      where_node = event.location
      events.push({title: title,
                   body: @EventClass.description(content),
                   calendar: @name,
                   where: where_node,
                   when_start_raw: @EventClass.set_when_raw(when_node_start),
                   when_end_raw: @EventClass.set_when_raw(when_node_end),
                   when_start: @EventClass.set_when(when_node_start),
                   when_end: @EventClass.set_when(when_node_end)
                  })
    end

    @data = events
    @data.sort! { |a, b| a[:when_start_raw] <=> b[:when_start_raw] }
  end

  def data
    @data
  end


  # logic moved out of structure passed to events.push, above.
  # In order to facilitate rspec testing
  class Event

    def description(content)
      content ? content : ""
    end

    def set_when_raw(when_node_raw)
      when_node_raw ? when_node_raw.to_time.to_i : 0
    end

    def set_when(when_node)
      when_node ? when_node.to_time : "No time"
    end
  end
end
