class UsersController < ApplicationController
  before_action :set_user, only: %i[ destroy ]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully deleted.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      current_user?(@user)
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :fullname, :photo, :cover_image)
    end
end
