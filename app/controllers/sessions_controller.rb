class SessionsController < ApplicationController
  before_action :check_if_signed_in, only: [:new]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params["username"],
                                    user_params["password"])
    if user
      log_in(user)
      redirect_to cats_url
    else
      flash[:errors] = "Invalid Credentials"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to new_session_url
  end

  def check_if_signed_in
    redirect_to cats_url unless current_user.nil?
  end
end
