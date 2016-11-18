class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, except: [:index, :new, :create]
  before_action :valid_user, only: [:edit, :update]

  def index
    @users = User.paginate page: params[:page],
      per_page: Settings.per_page_users
  end

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
    @relationship = if current_user.following? @user
      current_user.active_relationships.find_by followed_id: @user.id
    else
      @relationship = current_user.active_relationships.build
    end
  end

  def edit
    
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).
      permit :name, :email, :password, :password_confirmation
  end

  def valid_user
    redirect_to root_url unless @user.current_user? current_user
  end
end
