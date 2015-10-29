class AdjustmentPolicy < ApplicationPolicy
  def show?
    user.instructor? || (user.student? && record.checkin.student_id == user.student.id)
  end

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
