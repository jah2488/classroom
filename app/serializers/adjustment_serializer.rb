class AdjustmentSerializer < ActiveModel::Serializer
  attributes :id, :state, :created_at
  belongs_to :checkin
end
