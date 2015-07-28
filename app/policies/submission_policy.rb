class SubmissionPolicy < ApplicationPolicy
  def new?
    user
  end

  def create?
    user
  end

  def update?
    if user.instructor?
      user.has_student? record.student
    else
      record.student_id == user.id
    end
  end

  def show?
    update?
  end

  def complete?
    user.instructor? && user.has_student?(record.student)
  end

  def unfinish?
    complete?
  end
end
