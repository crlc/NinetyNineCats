class UsersController < ApplicationController
  before_action :check_if_signed_in, only: [:new]
  before_action :check_if_right_user, only: [:show]

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Welcome to the app"
      log_in(@user)
      redirect_to cats_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = current_user
    render :show
  end

  def check_if_right_user
    if current_user.nil?
      redirect_to cats_url
    end
  end

  def check_if_signed_in
    redirect_to cats_url unless current_user.nil?
  end
end
