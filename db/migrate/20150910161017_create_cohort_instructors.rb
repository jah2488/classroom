class CreateCohortInstructors < ActiveRecord::Migration
  def up
    enable_extension 'uuid-ossp'
    create_table :cohorts_instructors, id: :uuid do |t|
      t.integer :cohort_id
      t.integer :instructor_id
    end

    Cohort.all.each do |c|
      CohortInstructor.create!(cohort: c, instructor_id: c.instructor_id)
    end
  end
end
