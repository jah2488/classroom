class CohortPolicy < ApplicationPolicy
  def new?
    user.instructor?
  end

  def create?
    user.instructor?
  end

  def show?
    user.instructor? || (user.student? && user.in_cohort?(record))
  end

  def update?
    user.instructor? && user.in_cohort?(record)
  end

  def destroy?
    user.instructor? && user.in_cohort?(record)
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
