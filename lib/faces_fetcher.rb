require 'json'

class FacesFetcher
  @@defaultPhotoURL =  "https://pivots.cfapps.io/assets/default_directory_profile_photo.png"
  @@localDefaultImage = "/assets/default_directory_profile_photo.png"

  def initialize(pivots_url)
    @pivots ||= JSON.parse(Net::HTTP.get(URI(pivots_url)))
    #puts "HERE: ", @pivots
  end

  def new_pivots(location)
    @new_pivots = all_pivots_by_location(location).sort do |p1, p2|
      p2['started_on'] <=> p1['started_on']
    end.select do |p3|
      p3['photo_url'] != @@defaultPhotoURL
    end[0..9].map do |pivot|
      {
          first_name: pivot['first_name'],
          last_name: pivot['last_name'],
          photo_url: pivot['photo_url'],
          title: pivot['title']
      }
    end
  end

  def all_pivots(location)
    @all_pivots = all_pivots_by_location(location).select do |p1|
      p1['photo_url'] != @@defaultPhotoURL
    end.map do |pivot|
      {
        first_name: pivot['first_name'],
        last_name: pivot['last_name'],
        photo_url: pivot['photo_url'],
        title: pivot['title']
      }
    end
  end

  def all_pivots_by_location(location)
    @all_pivots_by_location = @pivots.select do |pivot|
      pivot['location_name'] == location
    end
    #puts "HERE 2: ", @all_pivots_by_location
    #return @all_pivots_by_location
  end
end

