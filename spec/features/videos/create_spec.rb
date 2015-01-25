require 'spec_helper'

describe "Creating videos" do 
  before do 
    visit new_video_path
  end

  it "should create a video" do 
    fill_in "Title", with: "New video"
  end
end