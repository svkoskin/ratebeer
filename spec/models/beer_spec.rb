require 'spec_helper'

describe Beer do
  it "is saved with name and style" do
    beer = Beer.create name:"Kilju", style:"Weizen"

    expect(beer.valid?).to be(true)
    expect(Beer.count).to eq(1)
  end

  it "is not saved without a name" do
    beer = Beer.create name:"", style:"Weizen"

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end

  it "is not saved without a style" do
    beer = beer.create name:"Kilju", style:""

    expect(beer.valid?).to be(false)
    expect(Beer.count).to eq(0)
  end
end
