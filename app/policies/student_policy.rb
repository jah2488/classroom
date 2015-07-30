class StudentPolicy < ApplicationPolicy
  def show?
    instructor_or_self || record.cohort_id == user.cohort_id
  end

  def edit?
    if user.student?
      user.student.id == record.id
    else
      false
    end
  end

  def update?
    instructor_or_self
  end

  def grades?
    instructor_or_self
  end

  def instructor_or_self
    if user.instructor?
      user.instructor.has_student? record
    else
      record.user.id == user.id
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
