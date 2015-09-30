class Student < ActiveRecord::Base
  belongs_to :user
  belongs_to :cohort
  has_many :submissions
  has_many :assignments, -> { uniq }, through: :submissions
  has_many :complete_assignments, -> { where(submissions: { completed: true }).uniq }, through: :submissions, source: :assignment
  has_many :badges, through: :submissions
  has_many :checkins
  has_many :reports
  has_many :adjustments, through: :checkins
  accepts_nested_attributes_for :user
  validates_presence_of :cohort

  def self.search(user, query)
    users = User.where("email || ' ' || name ILIKE (?)", "%#{query}%")
    students = users.map(&:student)
    if user && user.instructor?
      instructor = user.instructor
      students.select{|s| instructor.has_student?(s)}
    elsif user && user.student?
      cohort_id = user.student.cohort_id
      students.select{|s| s.cohort_id == cohort_id}
    else
      []
    end
  end

  def marked_checkins
    checkins.includes(:adjustment).select { |checkin| checkin.late }
  end

  def tardies
    checkins.select { |c| c.late }.count
  end

  def absences
    cohort.days.count - checkins.count
  end

  def completed_assignments
    submissions.where(completed: true)
  end

  def complete_percentage
    (complete_assignments.count.to_f / cohort.assignments.count.to_f).round(2)
  end

  def past_due_count
    Assignment.late_for(self).count
  end

  def name
    (user.name || user.email) if user
  end

  def to_s
    if user
      user.to_s
    else
      "StudentID#{self.id}"
    end
  end
end
