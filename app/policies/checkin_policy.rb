class CheckinPolicy < ApplicationPolicy
  def create?
    user.student?
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
