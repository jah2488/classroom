class Day < ActiveRecord::Base
  belongs_to :cohort
  has_many :checkins
  has_many :students, through: :checkins

  def self.current_for(cohort)
    where(cohort_id: cohort.id).last
  end

  def starts_at
    start_time.strftime("%I:%M%p")
  end

  def late_time
    (start_time + 15.minutes).strftime("%I:%M%p")
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
