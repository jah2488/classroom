class Day < ActiveRecord::Base
  belongs_to :cohort
  has_many :checkins
  has_many :students, through: :checkins
  validates :start, presence: true

  def self.for(cohort)
    where(cohort_id: cohort.id)
  end

  def self.current_for(cohort)
    self.for(cohort).last
  end

  def to_s
    self.start.strftime("%b %e, %y") if start
  end

  def unaccounted_for_students
    cohort.students - students
  end

  def has_checkin_for?(student)
    checkins.where(student_id: student.id).count > 0
  end

  def starts_at
    start.strftime("%I:%M%p") if start
  end

  def late_at
    late_time.strftime("%I:%M%p")
  end

  def late_time
    (start + 15.minutes)
  end

  def created_on
    created_at.strftime("%A, %B #{created_at.day.ordinalize}")
  end

  #remain until prod is migrated
  def start
    return read_attribute(:start) if read_attribute(:start)
    read_attribute(:start_time).to_datetime if read_attribute(:start_time)
  end

  #deprecated
  def start_time
    return read_attribute(:start_time) if read_attribute(:start_time)
    start.to_time if read_attribute(:start)
  end

  def present?(student)
    students.include?(student)
  end

  def checkin_for(student)
    checkins.find { |chk| chk.student == student }
  end
end
