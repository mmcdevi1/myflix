require 'spec_helper'

describe Video do
  it "saves itself" do 
    video = Video.new(title: "new title", description: "new description")
    video.save
    expect(Video.count).to eq(1)
    expect(Video.first).to eq(video)
  end

  describe "Relationships" do 
    it { should belong_to(:category) }
  end

  describe "Validations" do 
    let(:video) { Video.create(title:"new title", description:"new description") }

    it "requires a title" do 
      expect(video).to validate_presence_of(:title)
    end

    it "requires a description" do 
      expect(video).to validate_presence_of(:description)
    end
  end
end
