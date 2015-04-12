class Checkin < ActiveRecord::Base
  belongs_to :student
  belongs_to :day

  def checkin_time
    created_at.strftime("%I:%M%p")
  end

  def status
    return 'late' if late
    'ontime'
  end

  def checkin_status
    "Checked In #{status} at #{checkin_time}"
  end

end
