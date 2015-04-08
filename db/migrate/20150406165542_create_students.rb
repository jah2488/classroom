class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :github
      t.string :phone
      t.string :blog
      t.text :bio
      t.belongs_to :cohort, index: true, null: false

      t.timestamps null: false
    end
    add_foreign_key :students, :cohorts
  end
end
