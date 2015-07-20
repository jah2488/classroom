class SubmissionPolicy < ApplicationPolicy
  def new?
    user
  end

  def create?
    user
  end

  def update?
    if user.instructor?
      instructor_has_student?(user, record.student)
    else
      record.student_id == user.id
    end
  end

  def show?
    if user.instructor?
      instructor_has_student?(user, record.student)
    else
      record.student_id == user.id
    end
  end
end
