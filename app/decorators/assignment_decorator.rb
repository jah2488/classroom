class AssignmentDecorator < Draper::Decorator
  delegate_all

  def title
    object.title.titleize
  end

  def due_date_in_words
    return unless object.due_date
    words = h.time_ago_in_words(object.due_date)
    if object.due_date.past?
      "Due #{words} ago"
    else
      "Due in #{words}"
    end
  end

  def start_in_words
    return unless object.start_at
    words = h.time_ago_in_words(object.start_at)
    if object.start_at.past?
      "Started #{words} ago"
    else
      "Starts in #{words}"
    end
  end

  def status(student)
    case
    when object.completed_by?(student)            then 'completed'
    when object.incomplete_by?(student)           then 'incomplete'
    when object.submissions_for(student).present? then 'pending'
    when object.late?                             then 'late'
    end
  end
end
