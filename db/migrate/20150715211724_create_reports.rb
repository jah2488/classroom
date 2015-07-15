class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.belongs_to :student
      t.belongs_to :day
      t.integer :participation
      t.string :participation_comments
      t.integer :effort
      t.string :effort_comments
      t.integer :skill
      t.string :skill_comments
      t.integer :overall
      t.string :overall_comments
      t.integer :status
      t.timestamps
    end
  end
end
