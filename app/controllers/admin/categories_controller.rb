class Admin::CategoriesController < ApplicationController

  include CategoryUtils

  before_action :logged_in_user, :require_admin
  before_action :find_category, except: [:index, :new, :create]

  def index
    @categories = Category.search params[:search]
  end

  def new
    @category = Category.new
    render layout: false
  end

  def show
    @word = Word.new
    Settings.mininum_answers_count.times {@word.answers.build}
    @words = @category.words
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
end
