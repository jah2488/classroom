class Adjustment < ActiveRecord::Base
  belongs_to :checkin

  OPEN     = 'OPENED'
  CLOSED   = 'CLOSED'
  ADJUSTED = 'ADJUSTED'

  STATES = [
    OPEN,
    ADJUSTED,
    CLOSED
  ]
end
