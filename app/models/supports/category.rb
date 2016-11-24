class Supports::Category

  def initialize category
    @category = category
  end

  def lessons
    @lessons = @category.lessons
  end

  def lesson
    @lesson = Lesson.new
  end
end
