require 'spec_helper'

describe User do
  it "has the username set correctly" do
    user = User.new username: "Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"
    
    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end
  
  it "is saved with a proper password" do
    user = User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1"

    expect(user.valid?).to be(true)
    expect(User.count).to eq(1)
  end  

  it "is not saved with a too short password" do
    user = User.create username:"Pekka", password:"aA1", password_confirmation:"aA1"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end

  it "is not saved with a password which has no numbers" do
    user = User.create username:"Pekka", password:"aAaa", password_confirmation:"aAaa"

    expect(user.valid?).to be(false)
    expect(User.count).to eq(0)
  end
end
