class SessionsController < ApplicationController
  skip_before_action :logged_in_user, only: [:new, :create]

  def new; end

  # "Create" a login, aka "log the user in"
  def create
    user = User.find_by(username: params[:session][:username])
    if user
      log_in user
      redirect_to root_path
    else
      flash.now[:danger] = 'Invalid username. Please enter a valid username or signup for a new account'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
