module CategoryUtils

  def find_category id = -1
    if id == -1
      @category = Category.find_by id: params[:id]
    else
      @category = Category.find_by id: id
    end
    if @category.nil?
      render "layouts/404_not_found"
    end
  end

  def search_categories
    @categories = Category.search(params[:search]).paginate page: params[:page],
      per_page: Settings.per_page_users
  end

  def words_count
    @words_count = Hash.new
    @categories.each do |category|
      @words_count[category.id] = category.words.
        learned_words(current_user.id, category.id).size
    end
  end
end
