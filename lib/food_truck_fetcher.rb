require 'uri'
require 'nokogiri'

class FoodTruckFetcher
  def data
    html = Net::HTTP.get(URI('http://www.seattlefoodtruck.com/schedule/occidental-park-food-truck-pod'))
    doc = FoodTruckDoc.new

    parser = Nokogiri::HTML::SAX::Parser.new(doc)
    parser.parse(html)

    doc.day(date_to_get)
  end

  private

  def date_to_get
    two_oclock = DateTime.new(Date.today.year, Date.today.month, Date.today.day, 14, 0, 0, Rational(-8, 24))

    if DateTime.now >= two_oclock
      Date.today + 1.day
    else
      Date.today
    end
  end

  class FoodTruckDoc < Nokogiri::XML::SAX::Document
    def initialize
      @the_list = false
      @days = []
      @current_day = nil

      @months = %w[skip January February March April May June July August September November December]
    end

    def day(date)
      which_day = @days.find do |d|
        d[:day_parts][:year].to_i == date.year &&
          d[:day_parts][:month].strip == @months[date.month] &&
          d[:day_parts][:day_of_month].to_i == date.day
      end

      cleanup which_day
    end

    def start_element(name, attrs = [])
      if name == 'dl' && has_class?(attrs, 'simcal-events-list-container')
        @the_list = true
      end

      if name == 'dt' && @the_list
        @current_day = {
          day_parts: {
            day_of_week: '',
            day_of_month: '',
            month: '',
            year: ''
          },
          trucks: []
        }
        @days << @current_day
      end

      if @current_day && has_class?(attrs, 'simcal-date-format')
        case attr_val(attrs, 'data-date-format')
        when 'l,'
          @text = lambda { |incoming| @current_day[:day_parts][:day_of_week] << incoming }
        when 'd'
          @text = lambda { |incoming| @current_day[:day_parts][:day_of_month] << incoming }
        when 'F'
          @text = lambda { |incoming| @current_day[:day_parts][:month] << incoming }
        when 'Y'
          @text = lambda { |incoming| @current_day[:day_parts][:year] << incoming }
        end
      end

      if @current_day && has_class?(attrs, 'simcal-event-details')
        @current_truck = { name: '', type: '' }
        @current_day[:trucks] << @current_truck
      end

      if @current_day && has_class?(attrs, 'simcal-event-title')
        @text = lambda { |incoming| @current_truck[:name] << incoming }
      end

      if @current_day && has_class?(attrs, 'simcal-event-description')
        @text = lambda { |incoming| @current_truck[:type] << incoming }
      end
    end

    def end_element(name)
      @text = nil
      if name == 'dl' && @the_list
        @current_day = nil
        @current_truck = nil
      end
    end

    def characters(str)
      if @text
        @text.call(str)
      end
    end

    private

    def has_class?(attrs, class_name)
      attr_val(attrs, 'class').split(' ').include?(class_name)
    end

    def attr_val(attrs, attr_name)
      attr = attrs.select { |(name, value)| name == attr_name }
      attr.first.nil? ? '' : attr.first.last
    end

    def cleanup(truck_info)
      {
        title: "#{truck_info[:day_parts][:day_of_week].sub(/, ?$/, '')}'s Food Trucks",
        trucks: truck_info[:trucks]
      }
    end
  end
end
