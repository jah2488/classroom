class Submission < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment
  has_many :ratings

  PENDING = 1
  IN_PROGRESS = 2
  GRADED = 3

  def self.ungraded_for(cohort)
    includes(:ratings, :assignment)
      .where(completed: nil,
            ratings: { submission_id: nil }, #Not sure if ratings will be used this way in future
            assignments: { cohort_id: cohort.id}).order('assignments.due_date DESC')
  end

  def to_s
    "[#{student.name.titleize}] - #{link}"
  end
end
