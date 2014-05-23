require 'spec_helper'

feature "Dashboard" do
  scenario "User sees link to GitHub page" do
    authorize 'test_user', 'test_pass'

    get '/nyc'

    expect(last_response.body).to have_content 'github.com/pivotal/pivotal-life'
  end
end

