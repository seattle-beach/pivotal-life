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
require 'dotenv'

# override variables set from .env by config.ru with values from .env.test
Dotenv.overload('.env.test')

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
  c.filter_sensitive_data('TWITTER_CONSUMER_KEY') { ENV['TWITTER_CONSUMER_KEY'] }
  c.filter_sensitive_data('TWITTER_OAUTH_TOKEN') { ENV['TWITTER_OAUTH_TOKEN'] }
  c.filter_sensitive_data('TWITTER_CONSUMER_SECRET') { ENV['TWITTER_CONSUMER_SECRET'] }
  c.filter_sensitive_data('TWITTER_OAUTH_SECRET') { ENV['TWITTER_OAUTH_SECRET'] }
  c.filter_sensitive_data('PIVOTS_AUTH_TOKEN') { ENV['PIVOTS_AUTH_TOKEN'] }
  c.filter_sensitive_data('PIVOTS_EMAIL') do
    unless ENV['PIVOTS_EMAIL'].nil?
      ENV['PIVOTS_EMAIL'].gsub('+', '%20')
    end
  end
end

