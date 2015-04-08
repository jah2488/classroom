class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.string :name
      t.string :phone
      t.datetime :office_hours_start
      t.datetime :office_hours_end

      t.timestamps null: false
    end
  end
end
