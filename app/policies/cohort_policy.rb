class CohortPolicy < ApplicationPolicy
  def new?
    user.instructor?
  end

  def create?
    user.instructor?
  end

  def show?
    true
  end

  def update?
    record.instructor_id == user.id
  end

  def destroy?
    record.instructor_id == user.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
