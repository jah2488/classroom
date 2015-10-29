class AssignmentSerializer < ActiveModel::Serializer
  attributes :id, :start_at, :title, :info, :due_date, :created_at, :updated_at
  belongs_to :cohort
  has_many :submissions

  def attributes args
    data = super(args)
    data[:has_feedback] = has_feedback if current_user.student?
    data[:status] = status if current_user.student?
    data
  end

  def has_feedback
    object.submissions_for(current_user.student).any? { |s| s.has_feedback? }
  end

  def status
    object.decorate.status(current_user.student)
  end

  def submissions
    SubmissionPolicy::Scope.new(current_user, object.submissions).resolve
  end
end
