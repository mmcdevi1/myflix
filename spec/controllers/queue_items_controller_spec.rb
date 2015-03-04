require 'spec_helper'

describe QueueItemsController do
  let(:user) { Fabricate(:user) }

  describe "GET index" do 
    it "sets @queue_items to the queue items of the logged in user" do 
      session[:user_id] = user.id
      queue_items1 = Fabricate(:queue_item, user: user)
      queue_items2 = Fabricate(:queue_item, user: user)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_items1, queue_items2])
    end

    it "redirects to the login page for unauthenticated users" do 
      get :index
      expect(response).to redirect_to login_path
    end 
  end

  describe "POST create" do 
    context "authenticated users" do   
      before do 
        session[:user_id] = user.id
        @video = Fabricate(:video)
      end

      it "redirects to the my queue path" do 
        post :create, video_id: @video.id
        expect(response).to redirect_to queue_path
      end

      it "creates a queue item" do 
        post :create, video_id: @video.id
        expect(QueueItem.count).to eq(1)
      end

      it "creates the queue item that is associated with the video" do 
        post :create, video_id: @video.id
        expect(QueueItem.first.video).to eq(@video)
      end

      it "creates the queue item that is associated with signed in user" do 
        post :create, video_id: @video.id
        expect(QueueItem.first.user).to eq(user)
      end

      it "puts the video as the last one in the queue" do 
        monk = Fabricate(:video)
        Fabricate(:queue_item, video: monk, user: user)
        south_park = Fabricate(:video)
        post :create, video_id: south_park.id
        south_park_queue_item = QueueItem.where(video_id: south_park.id, user_id: user.id).first
        expect(south_park_queue_item.position).to eq(2)
      end

      it "does not add the video to the queue if the video is already in the queue" do 
        monk = Fabricate(:video)
        Fabricate(:queue_item, video: monk, user: user)
        post :create, video_id: monk.id
        expect(user.queue_items.count).to eq(1)
      end
    end

    context "unauthenticated users" do 
      it "redirects to the login page for unauthenticated users" do 
        post :create, video_id: 7
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "DELETE destroy" do 
    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      it "redirects to the queue page" do 
        queue_item = Fabricate(:queue_item)
        delete :destroy, id: queue_item.id
        expect(response).to redirect_to queue_path
      end

      it "deletes the queue item" do 
        queue_item = Fabricate(:queue_item, user: user)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(0)
      end

      it "does not delete the queue item if the queue item is not in the current users queue" do 
        bob = Fabricate(:user)
        queue_item = Fabricate(:queue_item, user: bob)
        delete :destroy, id: queue_item.id
        expect(QueueItem.count).to eq(1)
      end 

      it "normalizes the remaining queue items" do 
        queue_items1 = Fabricate(:queue_item, user: user, position: 1)
        queue_items2 = Fabricate(:queue_item, user: user, position: 2)
        delete :destroy, id: queue_items1.id
        expect(QueueItem.first.position).to eq(1)
      end
    end

    context "unauthenticated users" do 
      it "redirects to the login page for unauthenticated users" do 
        delete :destroy, id: 2
        expect(response).to redirect_to login_path
      end
    end
  end

  describe "POST update_queue" do 
    let(:queue_items1) { Fabricate(:queue_item, user: user, position: 1) }
    let(:queue_items2) { Fabricate(:queue_item, user: user, position: 2) }

    context "authenticated users" do 
      before do 
        session[:user_id] = user.id
      end

      context "with valid inputs" do 
        before do 
          post :update_queue, queue_items: [{ id: queue_items1.id, position: 2 }, { id: queue_items2.id, position: 1 }]
        end

        it "should redirect back to the queue page" do           
          expect(response).to redirect_to queue_path
        end

        it "reorders the queue items" do 
          expect(user.queue_items).to eq([queue_items2, queue_items1])
        end

        it "normalizes the position numbers" do 
          post :update_queue, queue_items: [{ id: queue_items1.id, position: 3 }, { id: queue_items2.id, position: 2 }]
          expect(user.queue_items.map(&:position)).to eq([1, 2])
        end
      end

      context "with invalid inputs" do 
        before do 
          post :update_queue, queue_items: [{ id: queue_items1.id, position: 2.1 }, { id: queue_items2.id, position: 1 }]
        end

        it "redirects to the queue page" do 
          expect(response).to redirect_to queue_path
        end

        it "sets the flash danger message" do 
          expect(flash[:danger]).to be_present
        end

        it "does not change the queue items" do 
          post :update_queue, queue_items: [{ id: queue_items1.id, position: 3 }, { id: queue_items2.id, position: 2.1 }]
          expect(queue_items1.reload.position).to eq(1)
        end
      end
    end

    context "with unauthenticated users" do 
      it "redirects to the login path" do 
        post :update_queue, queue_items: [{ id: queue_items1.id, position: 2 }, { id: queue_items2.id, position: 1 }]
        expect(response).to redirect_to login_path
      end
    end

    context "with queue items that do not belong to the current user" do 
      let(:bob) { Fabricate(:user) }

      before do 
        session[:user_id] = user.id
      end

      it "does not change the queue items" do 
        queue_items1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_items2 = Fabricate(:queue_item, user: user, position: 2)
        post :update_queue, queue_items: [{ id: queue_items1.id, position: 3 }, { id: queue_items2.id, position: 2 }]
        expect(queue_items1.reload.position).to eq(1)
      end
    end
  end
end










































