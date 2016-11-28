class Supports::Category

  def initialize item = {}
    @category = item[:category]
    @user = item[:user]
    @params_page = item[:params_page]
  end

  def lessons
    @lessons = @category.lessons.filter_by_user(@user.id).
      paginate page: @params_page, per_page: Settings.per_page_users
  end

  def lesson
    @lesson = Lesson.new
  end
end
