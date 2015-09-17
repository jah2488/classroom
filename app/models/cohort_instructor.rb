class CohortInstructor < ActiveRecord::Base
  self.table_name = "cohorts_instructors"
  belongs_to :cohort
  belongs_to :instructor
end
