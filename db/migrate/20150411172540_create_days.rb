class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.time :start_time
      t.belongs_to :cohort, index: true

      t.timestamps null: false
    end
    add_foreign_key :days, :cohorts
  end
end
