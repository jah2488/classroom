module DashboardHelper
  def due_in(assignment)
    distance = distance_of_time_in_words(Time.now, assignment.due_date, include_seconds: true)
    if assignment.late?
      "Due #{distance} ago"
    else
      "Due in #{distance}"
    end
  end

  def has_feedback?(submission)
    submission.ratings.count > 0 && submission.ratings.first.notes.length > 1
  end

  def feedback_label(submission)
    if has_feedback?(submission)
      as_label("Feedback")
    end
  end

  def status_for(assignment, student)
    case
    when assignment.completed_by?(student)            then as_label('Completed',  :success)
    when assignment.incomplete_by?(student)           then as_label('Incomplete', :warning)
    when assignment.submissions_for(student).present? then as_label('Pending')
    when assignment.late?                             then as_label('Late',       :danger)
    else
    end
  end

  private

  def as_label(msg, severity = :default)
    content_tag(:span, msg, class: "label label-#{severity}")
  end
end
