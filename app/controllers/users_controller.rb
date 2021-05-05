class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create, :index, :show]
  before_action :set_user, only: %i[edit update destroy]

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
    @user.photo = @user.avatar.key

    if @user.save
      log_in @user
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH /users/1
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    attach_avatar

    if @user.save
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
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
    params.require(:user).permit(:username, :fullname, :photo, :cover_image, :avatar)
  end


  def attach_avatar
    @user.photo = @user.avatar.key if @user.avatar.attached?
  end
end
