# -*- coding: utf-8 -*-
class BeermappingApi
  def self.place_with_id(place_id)
    Rails.cache.fetch("bmp_place_#{place_id}", :expires_in => 1.week ) { fetch_place_with_id(place_id) }
  end

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch("bmp_city_#{city}", :expires_in => 1.week ) { fetch_places_in(city) }
  end

  private

  def self.fetch_place_with_id(place_id)
    location_url = "http://beermapping.com/webservice/locquery/#{api_key}/"
    location_response = HTTParty.get "#{location_url}#{place_id}"

    locations_from_bmp = location_response.parsed_response["bmp_locations"]["location"]

    return [] if locations_from_bmp.is_a?(Hash) and locations_from_bmp['id'].nil?

    locations_from_bmp = [locations_from_bmp] if locations_from_bmp.is_a?(Hash)

    # Only return the first one (shouldn't IDs be unique?)
    Place.new(locations_from_bmp[0])
  end

  def self.fetch_places_in(city)
    places_url = "http://beermapping.com/webservice/loccity/#{api_key}/"
    places_response = HTTParty.get "#{places_url}#{ERB::Util.url_encode(city)}"
    places_from_bmp = places_response.parsed_response["bmp_locations"]["location"]

    return [] if places_from_bmp.is_a?(Hash) and places_from_bmp['id'].nil?

    places_from_bmp = [places_from_bmp] if places_from_bmp.is_a?(Hash)
    places_from_bmp.inject([]) do |set, location|
      set << Place.new(location)
    end
  end
  
  def self.api_key
    Settings.beermapping_apikey
  end
end
