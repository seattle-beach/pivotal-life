source 'https://rubygems.org'

gem 'dashing', :git => 'https://github.com/Shopify/dashing.git', :ref => '5b585d'
#gets pulled in as a dependency
#gem 'thor', '>= 0.19.1'
gem 'dotenv'
gem 'geocoder'
gem 'activesupport'
gem 'nokogiri'
gem 'rake'
gem 'twitter'
gem 'yelp'
gem 'jwt'
gem 'googleauth'
#gem 'google/apis/calendar_v3'
gem 'signet'
# need >= 0.9.pre3 for google-api-client
gem 'google-api-client', '>= 0.9.pre3'
gem 'eventmachine', '~> 1.0.8'

# so our Rakefile works everywhere
gem 'rspec'
gem 'jasmine'

group :development do
  gem 'guard-rspec'
end

group :development, :test do
  gem 'pry'
  gem 'vcr'
  gem 'webmock'
  gem 'rack-coffee'
end

group :test do
  gem 'capybara'
  gem 'timecop'
end
