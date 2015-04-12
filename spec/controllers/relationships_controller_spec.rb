require 'spec_helper'

describe RelationshipsController do
  let(:user) { Fabricate(:user) }
  let(:bob)  { Fabricate(:user) }
  let(:ali)  { Fabricate(:user) }
 
  describe "GET index" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      it "sets @relationships to the current user's following relationships" do 
        relationship = Fabricate(:relationship, follower_id: user.id, following_id: bob.id)
        get :index
        expect(assigns(:relationships)).to eq([relationship])
      end
    end
  end

  describe "POST delete" do 
    context "authenticated users" do 
      let(:relationship) { Fabricate(:relationship, follower_id: user.id, following_id: bob.id) }

      before do 
        session[:user_id] = user.id
        delete :destroy, id: relationship
      end

      it "deletes the relationship if the current user is the follower" do 
        expect(Relationship.count).to eq(0)
      end

      it "redirects to the people page" do 
        expect(response).to redirect_to people_path
      end

      it "does not delete the relationship if the current use is not the follower" do 
        relationship2 = Fabricate(:relationship, follower_id: ali.id, following_id: bob.id)
        delete :destroy, id: relationship2
        expect(Relationship.count).to eq(1)
      end
    end
  end

  describe "POST create" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id 
      end

      it "creates a relationship for the current user and profile user" do 
        post :create, following_id: bob.id
        expect(user.relationships.first.following).to eq(bob)
      end

      it "redirects to the peoples path" do 
        post :create, following_id: bob.id
        expect(response).to redirect_to people_path
      end

      it "does not allow the user to follow a user if already followed" do 
        relationship = Fabricate(:relationship, follower_id: user.id, following_id: bob.id)
        post :create, following_id: bob.id
        expect(Relationship.count).to eq(1)
      end

      it "does not allow a user to follow themselves" do 
        post :create, following_id: user.id
        expect(Relationship.count).to eq(0)
      end
    end
  end
end
