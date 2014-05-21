require 'spec_helper'

describe Office do
  describe "#has_config?" do
    it "returns true when the office has configuration information for a job" do

      config = {
        calendar: {
          url: "http://www.google.com"
        }
      }

      office = Office.new('test', config)
      expect(office.has_config?(:calendar)).to be_true
      expect(office.has_config?(:weather)).to be_false
    end
  end

  describe "#code" do
    it "returns the short name of the office" do
      config = {
        calendar: {
          url: "http://www.google.com"
        }
      }

      office = Office.new("nyc", config)
      expect(office.code).to eq "nyc"
    end

  end

end
