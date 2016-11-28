module ActivitiesHelper

  def user_name activity
    if activity.user.id == current_user.id
      t "activity_user_name_you"
    else
      activity.user.name
    end
  end

  def action_message activity
    case activity.action_type
    when Activity.types[:follow]
      t "activity_follow_message"
    when Activity.types[:unfollow]
      t "activity_unfollow_message"
    else
      t "activity_finished_lesson_message"
    end
  end

  def target_link activity
    if activity.action_type == Activity.types[:finished_lesson]
      @lesson = Lesson.find_by id: activity.target_id
      link_to @lesson.category.name, @lesson.category
    else
      user = User.find_by id: activity.target_id
      link_to user.name, user
    end
  end

  def score_message activity
    if activity.action_type == Activity.types[:finished_lesson]
      t("activity_score_message") + @lesson.get_score_text
    end
  end
end
