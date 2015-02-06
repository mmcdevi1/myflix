require 'spec_helper'

describe Video do
  describe "Relationships" do 
    it { should belong_to(:category) }
  end

  describe "Validations" do 
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:description) }
  end

  describe "search_by_title" do 
    let(:futurama) { Video.create(title: "futurama", description: "futurama ep 1", created_at: 1.day.ago) }
    let(:back_to_the_future) { Video.create(title: "back to the future", description: "time travel") }

    it "returns an empty array if there is no match" do 
      expect(Video.search_by_title("hello")).to eq([])
    end

    it "returns an array of one video for an exact match" do 
      expect(Video.search_by_title("futurama")).to eq([futurama])
    end

    it "returns an array of one video for a partial match" do 
      expect(Video.search_by_title("urama")).to eq([futurama])
    end

    it "returns an array of all matches ordered by created_at" do 
      expect(Video.search_by_title("futur")).to eq([back_to_the_future, futurama])
    end

    it "returns an empty array for a search with an empty string" do 
      expect(Video.search_by_title("")).to eq([])
    end
  end
end
