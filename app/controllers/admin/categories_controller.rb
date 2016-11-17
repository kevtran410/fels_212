class Admin::CategoriesController < ApplicationController

  before_action :logged_in_user, :require_admin
  before_action :find_category, only: [:edit, :update, :destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
    render layout: false
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash.now[:success] = t "admin.create_new_category_success_msg"
    end
    respond_to do |format|
      format.js
    end
  end

  def edit
    render layout: false
  end

  def update
    if @category.update_attributes category_params
      flash.now[:success] = t "admin.edit_category_success_message"
    end
    respond_to do |format|
      format.js
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t "admin.delete_category_success_message"
    respond_to do |format|
      format.js
    end
  end

  private
  def category_params
    params.require(:category).permit :name, :duration, :word_count
  end

  def find_category
    @category = Category.find_by id: params[:id]
    if @category.nil?
      flash[:danger] = t "category_not_found_message"
      redirect_to admin_categories_path
    end
  end
end
