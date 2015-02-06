require 'spec_helper'

describe Category do
  describe "Relationships" do 
    it { should have_many(:videos) }
  end

  describe "#recent_videos" do 
    let!(:comedies)   { Category.create(name: "comedies") }
    let!(:futurama)   { Video.create(
                          title: "Futurama", 
                          description: "space travel", 
                          category: comedies, 
                          created_at: 1.day.ago) 
                      }
    let!(:south_park) { Video.create(
                          title: "South Park", 
                          description: "Funny", 
                          category: comedies) 
                      }    

    it "returns the videos in the reverse order by created_at" do 
      expect(comedies.recent_videos).to eq([south_park, futurama])
    end

    it "returns all the videos if there are less than 6 videos" do 
      expect(comedies.recent_videos.count).to eq(2)
    end

    it "returns 6 videos if there are more than 6 videos" do 
      7.times {
        Video.create(
          title: "foo", 
          description: "bar", 
          category: comedies)                       
      }
      expect(comedies.recent_videos.count).to eq(6)
    end

    it "returns the most recent 6 videos" do 
      6.times {
        Video.create(
          title: "foo", 
          description: "bar", 
          category: comedies)                       
      }
      tonight_show = Video.create(title: "Tonight Show", description: "Jay leno", category: comedies, created_at: 1.day.ago)
      expect(comedies.recent_videos).not_to include(tonight_show)
    end

    it "returns an empty array if the category does not have any videos" do 
      drama = Category.create(name: "drama")
      expect(drama.recent_videos).to eq([])
    end
  end
end
