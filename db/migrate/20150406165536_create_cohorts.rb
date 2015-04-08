class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.string :name
      t.string :location
      t.belongs_to :instructor, index: true

      t.timestamps null: false
    end
    add_foreign_key :cohorts, :instructors
  end
end
