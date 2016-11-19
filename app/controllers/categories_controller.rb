class CategoriesController < ApplicationController

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.per_page_users
  end

  def show
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "category_not_found_message"
      redirect_to request.referrer || root_url
    end
  end
end
