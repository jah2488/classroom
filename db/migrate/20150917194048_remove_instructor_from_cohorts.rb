class RemoveInstructorFromCohorts < ActiveRecord::Migration
  def change
    remove_column :cohorts, :instructor_id, :integer
  end
end
