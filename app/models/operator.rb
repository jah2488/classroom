class Operator < ActiveRecord::Base
  has_and_belongs_to_many :campuses
  belongs_to :user

  def has_student?(student)
    return false unless student
    #unassigned students should be available by all
    student.cohort_id == nil || campuses.include?(student.cohort.campus)
  end

  def students
    campuses.map(&:students).flatten
  end
end
