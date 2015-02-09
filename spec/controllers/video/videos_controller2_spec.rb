require 'spec_helper' 

describe VideosController do 
  let(:user) { Fabricate(:user) }

  describe "GET index" do 
    context "authenticated users" do 
      before do         
        session[:user_id] = user.id
      end

      it "sets the @videos variable" do 
        video = Fabricate(:video)
        get :index
        expect(assigns(:videos)).to eq(video)
      end

      it "sets the @categories variable" do 
        movies = Category.create(name: "movies")
        comedies = Category.create(name: "comedies")
        get :index
        expect(assigns(:categories)).to eq([movies, comedies])
      end

      it "renders the index template" do 
        get :index
        expect(response).to render_template :index
      end
    end

    context "unauthenticated users" do 
      it "redirects to the login page" do 
        get :index
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "GET show" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      it "sets the @video variable" do 
        video = Fabricate(:video)
        get :show, id: video.id
        expect(assigns(:video)).to eq(video)
      end

      it "sets the @reviews variable" do 
        video  = Fabricate(:video)
        review = Fabricate(:review, video: video)
        get :show, id: video.id
        expect(assigns(:reviews)).to eq([review])
      end

      it "renders the show template" do 
        video  = Fabricate(:video)
        get :show, id: video.id
        expect(response).to render_template :show
      end
    end

    context "unauthenticated users" do 
      it "redirects the user to the login page" do 
        video = Fabricate(:video)
        get :show, id: video.id
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST search" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      # it "sets @results for authenticated users" do 
      #   futurama = Video.create(title: "Futurama", description: "description")
      #   post :search, search_term: 'rama'
      #   expect(assigns(:results)).to eq([futurama])
      # end
    end

    context "unauthenticated users" do 
      it "redirects to the login page" do 
        futurama = Video.create(title: "Futurama", description: "description")
        post :search, search_term: 'rama'
        expect(response).to redirect_to login_path
      end
    end
  end
end