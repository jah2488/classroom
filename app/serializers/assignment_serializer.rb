class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :title, :info, :due_date, :created_at, :updated_at, :has_feedback, :status
  belongs_to :cohort

  def has_feedback
    return nil unless current_user && current_user.student?
    object.submissions_for(current_user.student).any? { |s| s.graded? }
  end

  def status
    return nil unless current_user && current_user.student?
    object.decorate.status(current_user.student)
  end
end
