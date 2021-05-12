class FollowingsController < ApplicationController
  before_action :set_following, only: :destroy

  def create
    @following = Following.new(following_params)

    if @following.save
      redirect_to user_path(@following.followed_id), notice: 'You are now following this user.'
    else
      render :new
    end
  end

  def destroy
    user_id = @following.followed_id
    @following.destroy
    redirect_to user_path(user_id), notice: 'You have successfully unfollowed this user.'
  end

  private

  def set_following
    @following = Following.find(params[:id])
  end

  def following_params
    params.require(:following).permit(:follower_id, :followed_id)
  end
end
