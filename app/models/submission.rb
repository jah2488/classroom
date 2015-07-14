class Submission < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment
  has_many :ratings
  has_many :submission_badges
  has_many :badges, through: :submission_badges

  PENDING = 1
  # wat ^ aren't these the same?
  IN_PROGRESS = 2
  # wat ^ aren't these the same?
  GRADED = 3

  def self.ungraded_for(cohort)
      Submission.includes(:assignment)
        .where(state: Submission::PENDING)
        .where(completed: false).where("assignments.cohort_id = ?", cohort.id)
        .references(:assignment)
        .order('assignments.due_date DESC')
  end

  def graded?
    state == GRADED
  end

  def label
    completed ? 'Completed' : 'Incomplete'
  end

  def on_time
    late ? 'Late' : 'On Time'
  end

  def status
    "#{label} #{on_time}"
  end

  def to_s
    "#{(student.name || student.email)} - #{link[0..45]}"
  end
end
