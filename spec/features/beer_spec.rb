require 'spec_helper'

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery }

  it "can be added with a valid name" do
    visit new_beer_path
    fill_in("beer_name", with:"Koff 3:me")

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end
  
  it "adding beer without a name will fail" do
    visit new_beer_path
    fill_in("beer_name", with:"")

    expect{
      click_button('Create Beer')    
    }.to change{Beer.count}.by(0)

    expect(current_path).to eq(beers_path)
    expect(page).to have_content "Name can't be blank"
  end
end
