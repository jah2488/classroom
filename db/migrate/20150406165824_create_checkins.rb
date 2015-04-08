class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.belongs_to :student, index: true
      t.boolean :late,   default: false
      t.boolean :absent, default: false
      t.timestamps null: false
    end
    add_foreign_key :checkins, :students
  end
end
