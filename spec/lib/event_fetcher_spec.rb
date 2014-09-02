require 'spec_helper'

describe EventFetcher do
  let(:raw_events) do
    [
      {title: "New Year's Eve", :when_start => Time.parse('2013-12-31 22:30:00 UTC')},
      {title: "Tech Talk Lunch", :when_start => Time.parse('2014-01-01 12:30:00 UTC')},
      {title: "NYC.rb", :when_start => Time.parse('2014-01-01 06:30:00 UTC')},
      {title: "Whiskey Club", :when_start => Time.parse('2014-01-02 06:30:00 UTC')}
    ]
  end

  it "returns today's events" do
    fetcher = EventFetcher.new raw_events, Time.parse("2014-01-01 00:00:00 UTC")
    events = fetcher.fetch_events[:events_today]
    expect(events).to eq([
      {title: "Tech Talk Lunch"},
      {title: "NYC.rb"}
    ])
  end

  it "returns the upcoming events" do
    fetcher = EventFetcher.new raw_events, Time.parse("2014-01-01 00:00:00 UTC")
    events = fetcher.fetch_events[:events_upcoming]
    expect(events).to eq([
      {title: "Whiskey Club"}
    ])
  end

  it "can be limited to a certain number of events" do
    fetcher = EventFetcher.new raw_events, Time.parse("2014-01-01 00:00:00 UTC")
    events = fetcher.fetch_events(1)
    expect(events[:events_today]).to eq([
      {title: "Tech Talk Lunch"}
    ])

    expect(events[:events_upcoming]).to eq([])
  end
end
