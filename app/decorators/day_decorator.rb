class DayDecorator < Draper::Decorator
  delegate_all

  def starts_at
    object.start.in_time_zone(cohort.tz).strftime("%I:%M%p %Z") if object.start
  end

  def late_at
    object.late_time.in_time_zone(cohort.tz).strftime("%I:%M%p %Z")
  end

  def created_on
    created_at.strftime("%A, %B #{created_at.day.ordinalize}")
  end
end
