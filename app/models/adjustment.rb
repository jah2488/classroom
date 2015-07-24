class Adjustment < ActiveRecord::Base
  belongs_to :checkin
  validates :checkin, presence: true

  OPEN     = 'OPENED'
  CLOSED   = 'CLOSED'
  ADJUSTED = 'ADJUSTED'

  STATES = [
    OPEN,
    ADJUSTED,
    CLOSED
  ]
end
