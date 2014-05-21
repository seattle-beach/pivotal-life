class Offices
  def self.load(yaml)
    office_data = YAML.load(yaml)
    office_data.map do |data|
      Office.new(data[0], data[1])
    end
  end
end
