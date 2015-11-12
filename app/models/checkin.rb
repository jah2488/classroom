class Checkin < ActiveRecord::Base
  belongs_to :student
  belongs_to :day
  has_one :adjustment
  validates :day, :student, presence: true
  validates :student, uniqueness: { scope: :day,
                                     message: "should happen once per day" }

  def self.perform(student, distance, provided_code)
    return [:forbidden, "Not a student"] unless student
    checkin = Checkin.new
    checkin.student = student
    checkin.day = student.cohort.current_day
    return [:bad_request, "No class today"] if !checkin.day
    return [:bad_request, "Already checked in"] if checkin.day.has_checkin_for?(student)
    return [:forbidden, "Invalid override code"] if distance.to_i > 1.0 && provided_code != checkin.day.override_code
    checkin.save!
    checkin = checkin.decorate
    json = [
      checkin.created,
      checkin,
      checkin.stats
    ]
    [:created, json]
  end

  def on_time?
    created_at < day.late_time
  end

  def correct
    self.created_at = day.start
  end

  def late
    created_at > day.late_time
  end

  def late?
    late
  end

  def checkin_time
    created_at.in_time_zone(day.tz).strftime("%I:%M%p %Z")
  end

  def status
    return 'late' if late
    'on time'
  end

  def checkin_status
    "Checked In #{status} at #{checkin_time}"
  end

  def short_checkin_status
    "#{status.capitalize} on #{created_at.in_time_zone(day.tz).strftime('%e %b %l:%M%p %Z')}"
  end

  def as_hash
    self.attributes
      .merge({ student: student.attributes})
      .merge({checkin_status: checkin_status})
  end
end
