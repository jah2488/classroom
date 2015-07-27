class AdjustmentPolicy < ApplicationPolicy
  def adjust?
    user.instructor?
  end

  def create?
    user
  end

  def close?
    user.instructor?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
