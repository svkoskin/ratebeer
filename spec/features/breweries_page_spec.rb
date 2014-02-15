require 'spec_helper'

describe "Breweries page" do
  it "should not have any breweries before is has been created" do
    visit breweries_path
    expect(page).to have_content 'Listing breweries'
    expect(page).to have_content 'Number of active breweries: 0'
    expect(page).to have_content 'Number of retired breweries: 0'
  end

  describe "when breweries exist" do
    before :each do
      @active_breweries = ["Koff", "Karjala", "Schenkerla"]
      year = 1896
      @active_breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1, active: true)
      end

      @retired_breweries = ["Lahden sininen"]
      year = 1941
      @retired_breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1, active: false)
      end
    
      visit breweries_path
    end

    it "lists the existing breweries and their total number" do
      expect(page).to have_content "Number of active breweries: #{@active_breweries.count}"
      expect(page).to have_content "Number of retired breweries: #{@retired_breweries.count}"
      
      @active_breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
      @retired_breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "allows user to navigate to page of a Brewery" do
      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established at 1897"
    end
  end
end
