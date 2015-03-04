require 'spec_helper'

describe Review2sController do
  describe "POST create" do 
    let(:video) { Fabricate(:video) }

    context "authenticated users" do 
      let(:user) { Fabricate(:user) }

      before do 
        session[:user_id] = user.id
      end

      context "with valid inputs" do 
        before do 
          post :create, review2: { content: "something", rating: 1 }, video_id: video.id
        end

        it "redirects to the video show page" do 
          expect(response).to redirect_to video
        end

        it "creates a review" do
          expect(Review2.count).to eq(1)
        end

        it "creates a review associated to the video" do 
          expect(Review2.first.video).to eq(video)
        end

        it "creates a review associated to the user" do 
          expect(Review2.first.user).to eq(user)
        end
      end 

      context "with invalid inputs" do 
        before do 
          post :create, review2: { content: "something" }, video_id: video.id
        end

        it "does not create a review" do 
          expect(Review2.count).to eq(0)
        end

        it "renders tempalte to video show page" do 
          expect(response).to render_template 'videos/show'
        end

        it "sets @video" do 
          expect(assigns(:video)).to eq(video)
        end

        it "sets @review" do 
          review = Fabricate(:review, video: video)
          post :create, review: { rating: 3 }, video_id: video.id
          expect(assigns(:reviews)).to match_array([review])
        end
      end
    end

    context "unauthenticated users" do 
      it "redirects to the login page" do 
        post :create, review2: { content: "something", rating: 1 }, video_id: video.id
        expect(response).to redirect_to login_path
      end
    end
  end
end
































