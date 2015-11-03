class AssignmentPolicy < ApplicationPolicy
  def show?
    if user.instructor?
      true
    elsif user.student?
      same_cohort(user.student, record) && started
    end
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
    user.instructor? && user.instructor.cohort_ids.include?(record.cohort_id)
  end

  def same_cohort a, b
    a.cohort_id == b.cohort_id
  end

  def started
    return true unless record.start_at
    record.start_at < Time.now
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
