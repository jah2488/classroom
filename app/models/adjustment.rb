class Adjustment < ActiveRecord::Base
  belongs_to :checkin

  OPEN     = 'OPEN'
  CLOSED   = 'CLOSED'
  ADJUSTED = 'ADJUSTED'

  STATES = [
    OPEN,
    ADJUSTED,
    CLOSED
  ]
end
