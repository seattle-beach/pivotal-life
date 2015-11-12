require 'yaml'

conf = YAML::load_file('offices.yml')

offices = []
conf.each do |key, array|
  offices.push({'tag' => key, 'name' => array['name']})
end

offices.sort! {|x, y| x['name'] <=> y['name']}

send_event('office_links', { office_links: offices })

