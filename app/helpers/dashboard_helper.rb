module DashboardHelper

  def week_number(total, index)
    ((index + 1) - total).abs + 1
  end

  def status_for(assignment, student)
    case
    when assignment.completed_by?(student)            then 'Completed'
    when assignment.incomplete_by?(student)           then 'Incomplete'
    when assignment.submissions_for(student).present? then 'Pending'
    when assignment.late?                             then 'Late'
    end
  end

  private

  def has_feedback?(submission)
    ratings = submission.ratings
    ratings.present? && ratings.any? { |rating| rating.has_feedback? }
  end
end
