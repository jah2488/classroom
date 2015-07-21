class CohortDecorator < Draper::Decorator
  delegate_all
  decorates_association :current_day
end
