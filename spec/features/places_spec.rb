require 'spec_helper'

describe 'Places' do
  it 'if none are returned by the API, none are shown' do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        []
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula"    
  end

  it 'if one is returned by the API, it is shown at the page' do 
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:id => 1, :name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it 'if many are returned by the API, they are shown at the page' do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:id => 1, :name => "Oljenkorsi"),
          Place.new(:id => 2, :name => "Parmesan")
        ]
    )    

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button 'Search'
    
    expect(page).to have_content 'Oljenkorsi'
    expect(page).to have_content 'Parmesan'
  end
end
