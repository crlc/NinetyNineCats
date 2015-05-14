class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_session

  def log_in(user)
    session_token = SecureRandom.urlsafe_base64
    Session.create!(user_id: user.id,
                    session_token: session_token,
                    http_user_agent: request.env["HTTP_USER_AGENT"],
                    remote_ip: Faker::Internet.ip_v4_address)
    session[:session_token] = session_token
  end

  def log_out
    Session.find(params[:id]).destroy!
  end

  def current_user
    my_session = Session.find_by(session_token: session[:session_token])
    if my_session.nil?
      session[:session_token] = nil
      return nil
    end
    @current_user ||= User.find_by(id: my_session.user_id)
  end

  def current_session
    Session.find_by(session_token: session[:session_token])
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
