class StudentPolicy < ApplicationPolicy
  def show?
    staff_or_self || (user.student? && same_cohort(user.student, record))
  end

  def edit?
    update?
  end

  def update?
    staff_or_self
  end

  def grades?
    staff_or_self
  end

  def new?
    create?
  end

  def become?
    user.staff? && user.has_student?(record)
  end

  def create?
    user.staff?
  end

  def destroy?
    user.staff? && user.has_student?(record)
  end

  def staff_or_self
    if user.instructor?
      user.instructor.has_student? record
    elsif user.operator?
      user.operator.has_student? record
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
      elsif user.operator?
        scope.where(id: user.operator.students.map(&:id))
      elsif user.student? && user.student.cohort
        scope.where(id: user.student.cohort.student_ids)
      else
        []
      end
    end
  end
end
