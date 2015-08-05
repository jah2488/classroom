class CohortDecorator < Draper::Decorator
  delegate_all
  decorates_association :current_day
  decorates_association :instructor
end
