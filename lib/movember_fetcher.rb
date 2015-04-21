require 'nokogiri'
require 'open-uri'

class MovemberFetcher
  def initialize(team_number, page_source = nil)
    @team_number = team_number
    @page_source = page_source
  end

  def fetch
    {
      label: team_name,
      value: donations_raised
    }
  end

  private

  attr_reader :page_source

  def team_name
    team_page.css('h1')[1].content.strip
  end

  def donations_raised
    team_page.css('.key-statistic-value').first.content.split(' ').first
  end

  def team_page
    @team_page ||= Nokogiri::HTML(page_source)
  end

  def page_source
    @page_source ||= open(team_url)
  end

  def team_url
    "http://us.movember.com/team/#@team_number"
  end
end
