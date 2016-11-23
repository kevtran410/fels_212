class CategoriesController < ApplicationController
  include CategoryUtils

  before_action :search_categories, only: :index
  before_action :logged_in_user, :find_category, :find_words, only: :show

  include CategoryUtils

  before_action :find_category, only: :show

  def index
    if params[:search].present?
      respond_to do |format|
        format.js
      end
    end
  end

  def show
    if params[:search].present?
      respond_to do |format|
        format.js
      end
    else
      @support = Supports::Category.new @category
    end
  end

  private
  def find_words
    @words = if params[:search].present?
      Word.search params[:search], params[:id]
    else
      Word.find_all params[:id]
    end.paginate page: params[:page], per_page: Settings.per_page_users
  end
end
