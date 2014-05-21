require 'open-uri'

offices_yaml = File.read('offices.yml')
offices = Offices.load(offices_yaml)

SCHEDULER.every '1d', first_in: 0 do
  pivots_user_email = ENV['PIVOTS_EMAIL'] || 'PIVOTS_USER_EMAIL_MISSING'
  pivots_auth_token = ENV['PIVOTS_AUTH_TOKEN'] || 'PIVOTS_AUTH_TOKEN_MISSING'
  pivots_datasource = "https://pivotalpivots2.herokuapp.com/api/users.json?email=#{URI::encode(pivots_user_email)}&authentication_token=#{URI::encode(pivots_auth_token)}"

  offices.each do |office|
    send_event("pivot_faces_#{office.code}", {
      new_faces: NewFacesFetcher.new(pivots_datasource)[office.config["name"]],
      random_faces: RandomFacesFetcher.new(pivots_datasource)[office.config["name"]]
    })
  end

end
