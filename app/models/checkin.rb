class Checkin < ActiveRecord::Base
  belongs_to :student
  belongs_to :day
  has_one :adjustment

  def checkin_time
    created_at.strftime("%I:%M%p")
  end

  def status
    return 'late' if late
    'on time'
  end

  def checkin_status
    "#{'Never ' if absent}Checked In #{status} at #{checkin_time}"
  end

  def short_checkin_status
    if absent
      "Absent on #{created_at.strftime('%e %b %l:%M%p')}"
    else
      "#{status.capitalize} on #{created_at.strftime('%e %b %l:%M%p')}"
    end
  end

end
