class CreateSubmissionBadges < ActiveRecord::Migration
  def change
    create_table :submission_badges do |t|
      t.belongs_to :badge, index: true
      t.belongs_to :submission, index: true

      t.timestamps null: false
    end
    add_foreign_key :submission_badges, :badges
    add_foreign_key :submission_badges, :submissions
  end
end
