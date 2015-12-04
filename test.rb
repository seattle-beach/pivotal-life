require 'googleauth'
require 'google/apis/calendar_v3'
require 'nokogiri'

puts $:

calendar = Google::Apis::CalendarV3::CalendarService.new

scopes =  ['https://www.googleapis.com/auth/calendar']
calendar.authorization = Google::Auth.get_application_default(scopes)

events = calendar.list_events('pivotal.io_3sj0q4g8h4c79bscqh5mvj1158@group.calendar.google.com')
#puts JSON.pretty_generate(events.to_h)

