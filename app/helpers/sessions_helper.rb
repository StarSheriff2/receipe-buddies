module SessionsHelper
  def log_in(user)
    session[:current_user_id] = user.id
  end

  def current_user
    @current_user ||= session[:current_user_id] && User.find_by(id: session[:current_user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:current_user_id)
    @current_user = nil
  end

  def current_user?(user)
    user == current_user
  end
end
