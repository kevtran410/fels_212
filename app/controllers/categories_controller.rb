class CategoriesController < ApplicationController
  include CategoryUtils

  before_action :search_categories, only: :index
  before_action :logged_in_user, only: :show
  before_action :find_category, :find_words, only: :show

  include CategoryUtils

  before_action :find_category, only: :show

  def index
    if logged_in?
      words_count
    end
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
      @support = Supports::Category.new category: @category, user: current_user,
        params_page: params[:page]
    end
  end

  private
  def find_words
    @words = if params[:search].nil?
      Word.search "", params[:id]
    else
      Word.send(params[:filter], current_user.id, params[:id]).
        search(params[:search], params[:id]).send params[:select]
    end.paginate page: params[:page], per_page: Settings.per_page_users
  end
end
