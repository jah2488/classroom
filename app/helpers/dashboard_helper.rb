module DashboardHelper
  def due_in(assignment)
    distance = distance_of_time_in_words(Time.now, assignment.due_date, include_seconds: true)
    if assignment.late?
      "Due #{distance} ago"
    else
      "Due in #{distance}"
    end
  end

  def status_for(assignment, student)
    return content_tag(:span, 'Completed', class: 'label label-success') if assignment.completed_by?(student)
    return content_tag(:span, 'Incomplete', class: 'label label-warning') if assignment.incomplete_by?(student)
    return content_tag(:span, 'Late', class: 'label label-danger') if assignment.late?
  end
end
