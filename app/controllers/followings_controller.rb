class FollowingsController < ApplicationController
  before_action :set_following, only: [:show, :edit, :update, :destroy]

  # GET /followings
  def index
    @followings = Following.all
  end

  # GET /followings/1
  def show
  end

  # POST /followings
  def create
    @following = Following.new(following_params)

    if @following.save
      redirect_to @following, notice: 'Following was successfully created.'
    else
      render :new
    end
  end

  # DELETE /followings/1
  def destroy
    @following.destroy
    redirect_to followings_url, notice: 'Following was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_following
      @following = Following.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def following_params
      params.fetch(:following, {})
    end
end
