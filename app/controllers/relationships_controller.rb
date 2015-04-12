class RelationshipsController < ApplicationController
  before_action :require_user

  def index
    @relationships = current_user.relationships
  end

  def create
    leader = User.find(params[:following_id])
    relationship = current_user.relationships.build(following_id: params[:following_id])
    relationship.save if current_user.can_follow?(leader)
    redirect_to people_path
  end

  def destroy
    relationship = Relationship.find(params[:id])
    relationship.destroy if current_user == relationship.follower
    flash[:success] = "Unfollowed."
    redirect_to people_path
  end

  private
  def relationship_params
    params.require(:relationship).permit(:follower_id, :following_id)
  end

end
