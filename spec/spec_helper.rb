ENV['RACK_ENV'] = 'test'
ENV['JOB_PATH'] = '/no/where/to/go'
ENV['AUTH_USERNAME'] = 'test_user'
ENV['AUTH_PASSWORD'] = 'test_pass'

require 'dashing'
require 'capybara/rspec'
require 'capybara/dsl'
require 'vcr'
require 'pry'
require 'rack/test'

# Ensure that full Rack configuration is loaded (including auth)
def app
  @rack_app ||= Rack::Builder.parse_file('config.ru').first
end

# Rack::Test has better authentication testing than Capybara
RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end

VCR.configure do |c|
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.cassette_library_dir = 'spec/fixtures/cassettes'
end

