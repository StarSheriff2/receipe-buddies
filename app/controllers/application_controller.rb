class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :logged_in_user

  def index
    flash.notice = 'No page found at that address'
    redirect_to root_path
  end
end
