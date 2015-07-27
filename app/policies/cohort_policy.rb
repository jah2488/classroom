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
    user.instructor? && record.instructor_id == user.instructor.id
  end

  def destroy?
    user.instructor? && record.instructor_id == user.instructor.id
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
