class EventFetcher
  def initialize(events, starting_date = Date.today)
    @events = events
    @starting_date = starting_date
  end

  def fetch_events number_events=nil
    events = events_today(@events) | events_upcoming(@events)

    if number_events
      events = events[0...number_events]
    end

    {
      events_today: translate(events_today(events)),
      events_upcoming: translate(events_upcoming(events))
    }
  end

  private

  def events_today events
    events_by_filter(events) {|x,y| x == y}
  end

  def events_upcoming events
    events_by_filter(events) {|x,y| x > y}
  end

  def events_by_filter events
    events.select do |event|
      yield event[:when_start].beginning_of_day, @starting_date.beginning_of_day
    end
  end

  def translate(events)
    events.map do |event|
      {
        title: event[:title]
      }
    end
  end
end
