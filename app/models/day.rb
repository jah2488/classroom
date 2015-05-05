class Day < ActiveRecord::Base
  belongs_to :cohort
  has_many :checkins
  has_many :students, through: :checkins

  def self.current_for(cohort)
    where(cohort_id: cohort.id).last
  end

  def unaccounted_for_students
    cohort.students - students
  end

  def has_checkin_for?(student)
    checkins.where(student_id: student.id).count > 0
  end

  def starts_at
    start_time.strftime("%I:%M%p")
  end

  def late_at
    late_time.strftime("%I:%M%p")
  end

  def late_time
    (start_time + 15.minutes)
  end

  def created_on
    created_at.strftime("%A, %B #{created_at.day.ordinalize}")
  end

  def present?(student)
    students.include?(student)
  end

  def checkin_for(student)
    checkins.find { |chk| chk.student == student }
  end
end
