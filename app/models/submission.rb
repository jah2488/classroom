class Submission < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment
  has_many :ratings

  PENDING = 1
  IN_PROGRESS = 2
  GRADED = 3

  def self.ungraded_for(cohort)
      Submission.includes(:assignment)
        .where(completed: false).where("assignments.cohort_id = ?", cohort.id)
        .references(:assignment)
        .order('assignments.due_date DESC')
  end

  def to_s
    "#{(student.name || student.email)} - #{link[0..15]}"
  end
end
