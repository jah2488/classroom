class Checkin < ActiveRecord::Base
  belongs_to :student
  belongs_to :day
  has_one :adjustment
  validates :day, :student, presence: true

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
