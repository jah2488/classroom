class SubmissionDecorator < Draper::Decorator
  delegate_all
  decorates_association :student

  def link_domain
     URI.parse(object.link).host
  end

  def created
    object.created_at.in_time_zone(object.tz).strftime("%l:%M%P %Z, %m/%e")
  end
end
