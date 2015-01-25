require 'spec_helper'

describe Category do
  it "saves itself" do 
    category = Category.new(name: "comedy")
    category.save
    expect(Category.first).to eq(category)
  end

  describe "Relationships" do 
    it "has many videos" do 
      comedies = Category.create(name: "comedy")
      south_park = Video.create(title: "South Park", description: "Funny video", category: comedies)
      futurama = Video.create(title: "Futurama", description: "Funny video", category: comedies)
      expect(comedies.videos).to include(south_park, futurama)
    end

    it { should have_many(:videos) }
  end
end
