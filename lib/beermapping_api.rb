class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city) { fetch_places_in(city) }
  end

  private

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
    '656e871044a324d7d6fea7efc11f3f1a'
  end
end
