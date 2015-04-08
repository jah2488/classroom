class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :info
      t.datetime :due_date
      t.belongs_to :cohort, index: true

      t.timestamps null: false
    end
    add_foreign_key :assignments, :cohorts
  end
end
