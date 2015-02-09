require 'spec_helper'

describe VideosController do

  describe "GET show" do

    it "sets @video for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      get :show, id: video.id
      expect(assigns(:video)).to eq(video)
    end

    it "sets @reviews for authenticated users" do 
      session[:user_id] = Fabricate(:user).id
      video = Fabricate(:video)
      review1 = Fabricate(:review, video: video)
      review2 = Fabricate(:review, video: video)
      get :show, id: video.id
      assigns(:reivews).should =~ [review1, review2]
    end

    it "redirects the user to the sign in page" do 
      video = Fabricate(:video)
      get :show, id: video.id
      expect(response).to redirect_to login_path
    end

  end

  describe "POST search" do 

    # it "sets @results for authenticated users" do 
    #   session[:user_id] = Fabricate(:user).id
    #   futurama = Video.create(title: "Futurama", description: "description")
    #   post :search, search_term: 'rama'
    #   expect(assigns(:result)).to eq([futurama])
    # end

    it "redirects to sign in page for the users not signed in" do 
      futurama = Video.create(title: "Futurama", description: "description")
      post :search, search_term: 'rama'
      expect(response).to redirect_to login_path
    end

  end

end
