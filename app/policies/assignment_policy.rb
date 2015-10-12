class AssignmentPolicy < ApplicationPolicy
  def show?
    user.instructor? || (user.student? && same_cohort(user.student, record))
  end

  def edit?
    update?
  end

  def update?
    user.instructor?
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

  def same_cohort a, b
    a.cohort_id == b.cohort_id
  end

  class Scope < Scope
    def resolve
      if user.instructor?
        scope
      elsif user.student?
        scope.where(cohort_id: user.student.cohort_id)
      end
    end
  end
end
