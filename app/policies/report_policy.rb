class ReportPolicy < ApplicationPolicy
  def new?
    user.instructor?
  end

  def create?
    user.instructor?
  end

  def show?
    if user.instructor?
      user.has_student? record.student
    else
      record.student_id == user.id
    end
  end

  def update?
    create?
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope.where(student_id: user.students.map(&:id))
      else
        scope.where(student_id: user.id)
      end
    end
  end
end
