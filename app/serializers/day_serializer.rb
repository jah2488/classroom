class DaySerializer < ActiveModel::Serializer
  attributes :id, :start
  belongs_to :cohort
end
