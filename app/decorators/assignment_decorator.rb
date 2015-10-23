class AssignmentDecorator < Draper::Decorator
  delegate_all

  def title
    object.title.titleize
  end

  def due_date_in_words
    words = h.time_ago_in_words(self.due_date)
    if self.due_date.past?
      "Due #{words} ago"
    else
      "Due in #{words}"
    end
  end

  def start_in_words
    return unless self.start_at
    words = h.time_ago_in_words(self.start_at)
    if self.start_at.past?
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
