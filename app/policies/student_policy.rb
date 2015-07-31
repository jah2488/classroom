class StudentPolicy < ApplicationPolicy
  def show?
    instructor_or_self || (user.student? && same_cohort(user.student, record))
  end

  def edit?
    update?
  end

  def update?
    instructor_or_self
  end

  def grades?
    instructor_or_self
  end

  def new?
    create?
  end

  def create?
    user.instructor?
  end

  def destroy?
    user.instructor?
  end

  def instructor_or_self
    if user.instructor?
      user.instructor.has_student? record
    elsif user.student?
      record.id == user.student.id
    end
  end

  def same_cohort a, b
    a.cohort_id == b.cohort_id
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope.where(id: user.instructor.students.map(&:id))
      else
        scope.where(id: user.id)
      end
    end
  end
end
