class StudentPolicy < ApplicationPolicy
  def show?
    if user.instructor?
      user.has_student? record.student
    else
      record.id == user.id || record.cohort_id == user.cohort_id
    end
  end

  def edit?
    if user.student?
      user.student.id == record.id
    else
      false
    end
  end

  def update?
    if user.instructor?
      user.has_student? record.student
    else
      record.id == user.id
    end
  end

  def grades?
    if user.instructor?
      user.has_student? record.student
    else
      record.id == user.id
    end
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope.where(id: user.students.map(&:id))
      else
        scope.where(id: user.id)
      end
    end
  end
end
