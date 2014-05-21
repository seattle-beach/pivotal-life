require 'spec_helper'

describe Offices do
  describe "#load" do
    it "loads yaml and turns it into offices" do
      config = {
        ny: {
          calendar: {
            url: "http://www.google.com"
          }
        },
        sf: {
          calendar: {
            url: "http://www.google.com"
          }
        }
      }

      yaml = YAML.dump(config)

      offices = Offices.load(yaml)
      expect(offices.length).to eq 2
      expect(offices[0]).to be_an(Office)
    end

    it "it passes a config hash to each Office it creates" do
      config = {
        ny: {
          calendar: {
            url: "http://www.google.com"
          }
        }
      }

      yaml = YAML.dump(config)

      ny_office = Offices.load(yaml)[0]

      expect(ny_office.config).to be_a(Hash)
    end
  end
end
