class AssignmentDecorator < Draper::Decorator
  delegate_all

  def due_date_in_words
    words = h.time_ago_in_words(self.due_date)
    if self.due_date.past?
      "#{words} ago"
    else
      "in #{words}"
    end

  end
end
