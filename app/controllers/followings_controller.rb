class FollowingsController < ApplicationController
  before_action :set_following, only: %i[show edit update destroy]

  # GET /followings
  def index
    @followings = Following.all
  end

  # GET /followings/1
  def show; end

  # POST /followings
  def create
    @following = Following.new(following_params)

    if @following.save
      redirect_to user_path(@following.followed_id), notice: 'You are now following this user.'
    else
      render :new
    end
  end

  # DELETE /followings/1
  def destroy
    user_id = @following.followed_id
    @following.destroy
    redirect_to user_path(user_id), notice: 'You have successfully unfollowed this user.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_following
    @following = Following.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def following_params
    params.require(:following).permit(:follower_id, :followed_id)
  end
end
