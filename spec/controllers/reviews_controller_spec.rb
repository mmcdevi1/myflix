require 'spec_helper'

describe ReviewsController do

  describe "POST create" do 
    let(:video) { Fabricate(:video) }

    context "with authenticated users" do 
      let(:current_user) { Fabricate(:user) }
      before { session[:user_id] = current_user.id }

      context "with valid inputs" do
        before do 
          post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        end

        it "redirects to the video show page" do 
          response.should redirect_to video
        end

        it "should create a review" do 
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do 
          expect(Review.first.video).to eq(video)
        end

        it "creates a review associated with the user" do 
          expect(Review.first.user).to eq(current_user)
        end        
      end

      context "with invalid inputs" do 
        before do 
          post :create, review: { rating: 3 }, video_id: video.id
        end

        it "does not create a video" do 
          expect(Review.count).to eq(0)
        end

        it "renders the videos/show template" do 
          response.should render_template "videos/show"
        end

        it "sets @video" do 
          expect(assigns(:video)).to eq(video)
        end

        it "sets @reviews" do 
          review = Fabricate(:review, video: video)
          post :create, review: { rating: 3 }, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    context "with unauthenticated users" do 
      it "redirects to login path" do 
        post :create, review: Fabricate.attributes_for(:review), video_id: video.id
        response.should redirect_to login_path
      end
    end
  end

end















































