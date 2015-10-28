class ReportPolicy < ApplicationPolicy
  def new?
    user.instructor?
  end

  def create?
    user.instructor?
  end

  def show?
    if user.instructor?
      user.instructor.has_student? record.student
    elsif user.operator?
      user.operator.has_student? record.student
    elsif user.student?
      record.student_id == user.student.id
    end
  end

  def update?
    create?
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope.where(student_id: user.instructor.students.map(&:id))
      elsif user.operator?
        scope.where(student_id: user.operator.students.map(&:id))
      elsif user.student?
        scope.where(student_id: user.student.id)
      else
        []
      end
    end
  end
end
