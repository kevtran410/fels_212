module CategoryUtils

  def find_category id = -1
    if id == -1
      @category = Category.find_by id: params[:id]
    else
      @category = Category.find_by id: id
    end
    if @category.nil?
      flash[:danger] = t "category_not_found_message"
      redirect_to current_user.is_admin ? admin_categories_path : categories_path
    end
  end
end
