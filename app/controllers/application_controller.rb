class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper

  private
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = t "logged_in_user"
      redirect_to login_url
    end
  end

  def find_user
    @user = User.find_by id: params[:id]
    if @user.nil?
      render "layouts/404_not_found"
    end
  end

  def require_admin
    unless current_user.is_admin?
      render "layouts/404_not_found"
    end
  end
end
