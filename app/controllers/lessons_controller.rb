class LessonsController < ApplicationController

  include CategoryUtils

  before_action :logged_in_user
  before_action :find_lesson, only: [:show, :update]
  before_action :authorize_view_permission, only: :show

  def show
    @lesson.start_lesson if @lesson.init?
    @results = @lesson.results
  end

  def create
    find_category params[:lesson][:category_id]
    @lesson = @category.lessons.new user: current_user
    @lesson.save
    respond_to do |format|
      format.js
    end
  end

  def update
    if @lesson.finished?
      flash[:danger] = t "lesson_finished_error_message"
    else
      @lesson.assign_attributes lesson_params
      @lesson.spent_time = @lesson.category.duration * 60 -
        (@lesson.end_time - Time.now).to_i
      @lesson.assign_score
      @lesson.finished!
      create_activity current_user.id, @lesson.id
    end
    redirect_to @lesson.category
  end

  private
  def find_lesson
    @lesson = Lesson.find_by id: params[:id]
    if @lesson.nil?
      flash[:danger] = t "lesson_not_found_message"
      redirect_to request.referrer || root_url
    end
  end

  def lesson_params
    params.require(:lesson).permit :id, results_attributes: [:answer_id, :id]
  end

  def create_activity user_id, target_id
    Activity.create action_type: Activity.types[:finished_lesson],
      user_id: user_id, target_id: target_id
  end

  def authorize_view_permission
    unless current_user == @lesson.user
      flash[:danger] = t "view_lesson_access_denied_message"
      redirect_to request.referrer || root_url
    end
  end
end
