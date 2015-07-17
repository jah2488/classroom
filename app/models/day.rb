class Day < ActiveRecord::Base
  belongs_to :cohort
  has_many :checkins
  has_many :students, through: :checkins
  validates :start, presence: true

  def self.for(cohort)
    where(cohort_id: cohort.id)
  end

  def self.current_for(cohort)
    self.for(cohort).order(:start).last
  end

  def tz
    cohort.tz
  end

  def to_s
    self.start.strftime("%b %e, %y") if start
  end

  def unaccounted_for_students
    cohort.students - students
  end

  def absences?
    cohort.students != students
  end

  def has_checkin_for?(student)
    checkins.where(student_id: student.id).count > 0
  end

  def late_time
    (start + 15.minutes)
  end

  def week
    start.to_datetime.cweek
  end

  def present?(student)
    students.include?(student)
  end

  def checkin_for(student)
    checkins.find { |chk| chk.student == student }
  end
end
