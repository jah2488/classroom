class BadgePolicy < ApplicationPolicy
  def new?
    user.instructor?
  end

  def create?
    user.instructor?
  end

  def edit?
    user.instructor?
  end

  def show?
    true
  end

  def update?
    user.instructor?
  end

  def destroy?
    user.instructor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
