class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, only: :show

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "signup_success_welcome"
      log_in @user
      redirect_to root_url
    else
      render "new"
    end
  end

  def show

  end
  
  private
  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      flash[:danger] = t "cant_find_user"
    end
  end

  def user_params
    params.require(:user).
      permit :name, :email, :password, :password_confirmation
  end
end
