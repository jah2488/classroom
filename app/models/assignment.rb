class Assignment < ActiveRecord::Base
  belongs_to :cohort
  has_many :submissions, dependent: :destroy
  has_many :assignment_tags, dependent: :destroy
  has_many :tags, through: :assignment_tags
  validates :title, presence: true
  validates :cohort, presence: true

  def self.by_week(records)
    records.group_by { |assignment| assignment.due_date.beginning_of_week.to_date }
  end

  def self.search(user, query)
    if user && user.instructor?
      where(arel_table[:title].matches("%#{query}%"))
    elsif user && user.student?
      cohort_id = user.student.cohort_id
      where(arel_table[:title].matches("%#{query}%"), arel_table[:cohort_id].matches(cohort_id))
    else
      []
    end
  end

  def self.for(student)
    where("cohort_id = ? AND (start_at < ? OR start_at IS NULL)", student.cohort_id, Time.now).includes(:submissions).order(due_date: :DESC)
  end

  def self.current_for(student)
    self.for(student).not_late.first
  end

  def self.incomplete_for(student)
    self.for(student) - Assignment.complete_for(student)
  end

  def self.complete_for(student)
    self.for(student).where(submissions: { student_id: student.id, completed: true }).uniq
  end

  def self.not_late
    where(Assignment.arel_table[:due_date].gt(Time.zone.now))
  end

  def self.late
    where(Assignment.arel_table[:due_date].lt(Time.zone.now))
  end

  def submissions_for(student)
    submissions.includes(:ratings).where(student_id: student.id).order('created_at ASC')
  end

  def completed_by?(student)
    submissions_for(student).where(completed: true).count > 0
  end

  def pending_by?(student)
    submissions.where(student_id: student.id, completed: false, state: Submission::PENDING).count > 0
  end

  def incomplete_by?(student)
    submissions = Arel::Table.new(:submissions)
    student_submissions = submissions_for(student)
    student_submissions.where(submissions[:state].not_eq(Submission::PENDING),
                              submissions[:completed].eq(false)
                                .or(submissions[:completed].eq(nil))).count > 0 &&
    student_submissions.where(submissions[:completed].eq(true)).count == 0
  end

  def unsubmitted_by
    self.cohort.students.where("id NOT IN (?)", self.submissions.pluck(:student_id).uniq)
  end

  def late?
    Time.zone.now > due_date
  end

  def to_s
    "Title: #{title} | Due: #{due_date}"
  end
end
