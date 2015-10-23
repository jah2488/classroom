class CohortPolicy < ApplicationPolicy
  def new?
    user.staff?
  end

  def create?
    user.staff?
  end

  def show?
    user.staff? || (user.student? && user.in_cohort?(record))
  end

  def update?
    user.staff? && user.in_cohort?(record)
  end

  def destroy?
    update?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
