require  'spec_helper'
require 'timecop'
require 'time'

describe CalendarFetcher do

  # hardcoded for NYC Event calendar. see offices.yml
  let(:calendar_id) { 'pivotal.io_3sj0q4g8h4c79bscqh5mvj1158@group.calendar.google.com' }
  let(:fetcher) { CalendarFetcher.new }
  let(:event) { CalendarFetcher::Event.new }
  #let(:curr_zone) { Time.now.utc_offset }
  let(:curr_zone) { Time.now.strftime("%z") }


  it 'authorization test' do
    VCR.use_cassette('CalendarFetcher/auth') do
      cal = fetcher.client.get_calendar(calendar_id)
      expect(cal.id).to eq(calendar_id)
    end
  end



  it 'event description test' do
    expect(event.description(nil)).to eq ''
    expect(event.description('')).to eq ''
    expect(event.description('Please RSVP "Yes" or "No".')).to eq 'Please RSVP "Yes" or "No".'
  end

  it 'event raw DateTime bounds test' do
    expect(event.set_when_raw(nil)).to equal 0
    # correct for DateTime in GMT
    expect(event.set_when_raw(DateTime.new(2015,11,24,15,20,0))).to equal 1448378400
  end

  it 'event raw Date bounds test' do
    expect(event.set_when_raw(nil)).to equal 0
    # Date is created in midnight localtime, so here the epoch time is at this date+5hrs in GMT.
    # This is acceptable since Date is returned only for all-day events, and in local time
    # And the local dashboard cares about local midnight-to-midnight.
    # NOTE: no longer using a hardcoded epoch time since that's fixed to EST
    #expect(event.set_when_raw(Date.new(2015,11,24))).to equal 1448341200
    expect(event.set_when_raw(Date.new(2015,11,24))).to equal Time.new(2015,11,24).to_i
  end

  it 'event DateTime bounds test' do
    expect(event.set_when(nil)).to eq "No time"
    puts curr_zone
    expect(event.set_when(DateTime.new(2015,11,24,15,20,0,curr_zone))).to eq Time.new(2015,11,24,15,20,0)
    #expect(event.set_when(DateTime.iso8601("20151124T152000#{curr_zone}"))).to eq Time.new(2015,11,24,15,20,0)
  end

  it 'event Date bounds test' do
    expect(event.set_when(nil)).to eq "No time"
    expect(event.set_when(Date.new(2015,11,24))).to eq Time.new(2015,11,24,0,0,0)
  end

end
