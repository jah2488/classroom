class CheckinDecorator < Draper::Decorator
  delegate_all

  def created
    object.created_at.strftime("%l:%M%p")
  end

  def stats
    { tardies: object.student.tardies, absences: object.student.absences }
  end
end
