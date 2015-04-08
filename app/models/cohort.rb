class Cohort < ActiveRecord::Base
  belongs_to :instructor
  has_many :students
  has_many :assignments
end
