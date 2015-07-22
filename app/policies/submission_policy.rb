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

  def mark_complete?
    user.instructor? && user.has_student?(record.student)
  end

  def mark_unfinished?
    mark_complete?
  end

  def grade_submission?
    mark_complete?
  end
end
