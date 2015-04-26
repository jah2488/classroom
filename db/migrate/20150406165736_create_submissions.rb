class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :link
      t.text :notes
      t.integer :state, default: 1, null: false
      t.boolean :completed, default: false
      t.boolean :late,      default: false
      t.belongs_to :student, index: true
      t.belongs_to :assignment, index: true

      t.timestamps null: false
    end
    add_foreign_key :submissions, :students
    add_foreign_key :submissions, :assignments
  end
end
