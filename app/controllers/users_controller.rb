class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :create]
  before_action :find_user, except: [:index, :new, :create]
  before_action :valid_user, only: [:edit, :update]

  include CategoryUtils

  def index
    @users = User.search_users(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page_users
    if params[:search].present?
      respond_to do |format|
        format.js
      end
    end
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
    @categories = Category.ongoing_course(@user.id).
      paginate page: params[:page], per_page: Settings.per_page_courses
    words_count
    @support_user = Supports::User.new words_count: @words_count,
      user: current_user
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
