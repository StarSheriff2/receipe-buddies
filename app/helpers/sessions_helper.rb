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

  def store_session_logout_date
    current_user_id_cookie = "user_id_#{current_user.id}"
    cookies.encrypted[:logout_date] = { :value => { }.to_json, expires: 2.days } unless cookies[:logout_date]
    temp_logout = JSON.parse(cookies.encrypted[:logout_date])
    temp_logout[current_user_id_cookie] = Time.zone.now
    cookies.encrypted[:logout_date] = { value: JSON.generate(temp_logout), expires: 1.day }
  end

  def get_last_session_logout_date
    return unless cookies[:logout_date]
    decoded_cookie = JSON.parse(cookies.encrypted[:logout_date])
    current_user_id_cookie = "user_id_#{current_user.id}"
    decoded_cookie[current_user_id_cookie].to_datetime if decoded_cookie[current_user_id_cookie]
  end
end
