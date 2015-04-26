class Assignment < ActiveRecord::Base
  belongs_to :cohort
  has_many :submissions

  def self.for(student)
    where(cohort_id: student.cohort_id).order('due_date ASC')
  end

  def submissions_for(student)
    submissions.where(student_id: student.id).order('created_at ASC')
  end

  def completed_by?(student)
    submissions_for(student).where(completed: true).count > 0
  end

  def incomplete_by?(student)
    submissions = Arel::Table.new(:submissions)
    student_submissions = submissions_for(student)
    student_submissions.where(submissions[:state].not_eq(Submission::PENDING),
                              submissions[:completed].eq(false)
                                .or(submissions[:completed].eq(nil))).count > 0 &&
    student_submissions.where(submissions[:completed].eq(true)).count == 0
  end

  def late?
    Time.now > due_date
  end

  def to_s
    "Title: #{title} | Due: #{due_date}"
  end
end
