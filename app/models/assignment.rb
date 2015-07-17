class Assignment < ActiveRecord::Base
  belongs_to :cohort
  has_many :submissions
  has_many :assignment_tags
  has_many :tags, through: :assignment_tags
  validates :title, presence: true

  def self.by_week(records)
    records.group_by { |assignment| assignment.due_date.beginning_of_week.to_date }
  end

  def self.search(query)
    where(arel_table[:title].matches("%#{query}%"))
  end

  def self.for(student)
    where(cohort_id: student.cohort_id).includes(:submissions).order(due_date: :DESC)
  end

  def self.current_for(student)
    self.for(student).not_late.first
  end

  def self.late_for(student)
    self.for(student).late - student.assignments
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

  def due_date_in_words
    words = ActionController::Base.helpers.time_ago_in_words(self.due_date)
    if self.due_date.past?
      "#{words} ago"
    else
      "in #{words}"
    end
  end

  def submissions_for(student)
    submissions.includes(:ratings).where(student_id: student.id).order('created_at ASC')
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
    Time.zone.now > due_date
  end

  def to_s
    "Title: #{title} | Due: #{due_date}"
  end
end
