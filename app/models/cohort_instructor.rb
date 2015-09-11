class CohortInstructor < ActiveRecord::Base
  belongs_to :cohort
  belongs_to :instructor
end
