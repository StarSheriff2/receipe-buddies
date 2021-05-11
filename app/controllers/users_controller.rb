class UsersController < ApplicationController
  skip_before_action :logged_in_user, only: %i[new create]
  before_action :set_user, only: %i[edit update destroy]

  # GET /users/1
  def show
    @user = User.find(params[:id])
    @opinions = @user.opinions.ordered_by_most_recent
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # POST /users
  def create
    @user = User.new(user_params)
    @user.attach_avatar

    if @user.save
      log_in @user
      redirect_to @user,
                  notice: "Welcome, #{@user.fullname}.
                          You are now part of the biggest community of recipe enthusiasts in the world!"
    else
      render :new, status: :unprocessable_entity
    end
  rescue StandardError
    redirect_to new_user_path, notice: 'This username already exists. Please Choose another one.'
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PATCH /users/1
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    @user.attach_avatar

    if @user.save
      redirect_to @user, notice: 'You have successfully updated your profile.'
    else
      render :edit, status: :unprocessable_entity
    end
  rescue StandardError
    redirect_to edit_user_path, notice: 'This username is already taken. Please Choose another one.'
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to login_path, notice: 'Account deleted successfully.'
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
end
