class Submission < ActiveRecord::Base
  belongs_to :student
  belongs_to :assignment
  has_many :ratings
end
