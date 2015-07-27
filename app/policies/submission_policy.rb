class SubmissionPolicy < ApplicationPolicy
  def new?
    user
  end

  def create?
    user
  end

  def update?
    if user.instructor?
      user.instructor.has_student? record.student
    else
      record.student_id == user.student.id
    end
  end

  def show?
    update?
  end

  def complete?
    user.instructor? && user.instructor.has_student?(record.student)
  end

  def unfinish?
    complete?
  end
end
