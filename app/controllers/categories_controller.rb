class CategoriesController < ApplicationController
  include CategoryUtils

  before_action :logged_in_user, :find_category, :find_words, only: :show

  include CategoryUtils

  before_action :find_category, only: :show

  def index
    @categories = Category.search(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page_users
  end

  def show
    @support = Supports::Category.new @category
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
