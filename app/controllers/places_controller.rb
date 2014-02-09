class PlacesController < ApplicationController
  def index
  end

  def search
    beermapping_api_key = '656e871044a324d7d6fea7efc11f3f1a'
    places_url = "http://beermapping.com/webservice/loccity/#{beermapping_api_key}/"
    places_response = HTTParty.get "#{places_url}#{ERB::Util.url_encode(params[:city])}"
    places_from_bmp = places_response.parsed_response["bmp_locations"]["location"]

    if places_from_bmp.is_a?(Hash) and places_from_bmp['id'].nil?
      redirect_to places_path, :notice => "No places in #{params[:city]}"
    else
      places_from_bmp = [places_from_bmp] if places_from_bmp.is_a?(Hash)
      @places = places_from_bmp.inject([]) do |set, location|
        set << Place.new(location)
      end
      render :index
    end
  end
end
