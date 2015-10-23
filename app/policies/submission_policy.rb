class SubmissionPolicy < ApplicationPolicy
  def new?
    user.student?
  end

  def create?
    user.student?
  end

  def update?
    if user.student?
      record.student_id == user.student.id
    end
  end

  def show?
    if user.instructor?
      user.instructor.has_student? record.student
    else
      record.student_id == user.student.id
    end
  end

  def complete?
    user.instructor? && user.instructor.has_student?(record.student)
  end

  def unfinish?
    complete?
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope.where(student_id: user.instructor.students)
      elsif user.student?
        scope.where(student_id: user.student.id)
      end
    end
  end
end
