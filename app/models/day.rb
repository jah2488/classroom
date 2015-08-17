class Day < ActiveRecord::Base
  belongs_to :cohort
  has_many :checkins
  has_many :students, through: :checkins
  validates :start, presence: true
  validate :must_be_after_cohort_start_time
  validate :cannot_overlap_calendar_day

  def self.for(cohort)
    where(cohort_id: cohort.id)
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

  def must_be_after_cohort_start_time
    if self.start < cohort.start_time
      errors.add(:start, "can't be before cohort start time")
    end
  end

  def cannot_overlap_calendar_day
    calendar_day = self.start.to_datetime.in_time_zone(tz).mjd
    if cohort.days.find{|d| d.start.to_datetime.in_time_zone(tz).mjd == calendar_day }
      errors.add(:start, "cohort already has calendar day")
    end
  end
end
