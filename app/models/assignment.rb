class Assignment < ActiveRecord::Base
  belongs_to :cohort
  has_many :submissions

  def self.for(student)
    where(cohort_id: student.cohort_id)
  end

  def submissions_for(student)
    submissions.where(student_id: student.id)
  end

  def completed_by?(student)
    submissions_for(student).where(completed: true).count > 0
  end

  def to_s
    "Title: #{title} | Due: #{due_date}"
  end
end
