class SubmissionDecorator < Draper::Decorator
  delegate_all
  decorates_association :student

  def link_domain
     URI.parse(object.link).host
  end
end
