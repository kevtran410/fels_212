module LessonsHelper

  def score_field lesson
    lesson.get_score_text
  end

  def status_field lesson
    case lesson.status
    when "init"
      label :status, t("status_new"), class: "label label-primary"
    when "finished"
      label :status, t("status_finished"), class: "label label-success"
    else
      label :status, t("status_in_progress"), class: "label label-info"
    end
  end

  def spent_time_field lesson
    if lesson.spent_time.nil?
      "-"
    else
      minutes = (lesson.spent_time/60).to_i
      seconds = lesson.spent_time - minutes*60
      "#{minutes} : #{seconds}"
    end
  end

  def action_button lesson
    case lesson.status
    when "init"
      link_to t("button_start"), category_lesson_path(lesson.category, lesson),
        class: "btn btn-primary"
    when "finished"
      link_to t("button_view"), category_lesson_path(lesson.category, lesson),
        class: "btn btn-success"
    else
      link_to t("button_continue"), category_lesson_path(lesson.category,
        lesson), class: "btn btn-info"
    end
  end

  def answer_label result, answer
    if result.lesson.finished?
      if answer.is_correct?
        return label :answer_id, answer.content, value: answer.id,
          class: "text-success"
      elsif result.answer_id == answer.id && !answer.is_correct?
        return label :answer_id, answer.content, value: answer.id,
          class: "text-danger"
      end
    end
    label :answer_id, answer.content, value: answer.id
  end
end
