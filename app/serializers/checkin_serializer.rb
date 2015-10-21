class CheckinSerializer < ActiveModel::Serializer
  attributes :id, :created_at, :status
  belongs_to :student
end
