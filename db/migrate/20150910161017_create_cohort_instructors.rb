class CreateCohortInstructors < ActiveRecord::Migration
  def up
    enable_extension 'uuid-ossp'
    create_join_table :cohorts, :instructors, id: :uuid do |t|
      t.index :cohort_id
      t.index :instructor_id
    end

    Cohort.all.each do |c|
      CohortInstructor.create!(cohort: c, instructor_id: c.instructor_id)
    end
  end

  def down
    drop_join_table :cohorts, :instructors
  end
end
