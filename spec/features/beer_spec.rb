require 'spec_helper'
include OwnTestHelper

describe "Beer" do
  let!(:brewery) { FactoryGirl.create :brewery }
  let!(:user) { FactoryGirl.create :user }

  describe "(when user has logged in)" do
    before :each do
      sign_in(username:"Pekka", password:"Foobar1")
    end

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
end
