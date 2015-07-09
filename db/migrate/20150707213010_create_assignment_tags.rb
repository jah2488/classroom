class CreateAssignmentTags < ActiveRecord::Migration
  def change
    create_table :assignment_tags do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :assignment, index: true

      t.timestamps null: false
    end
    add_foreign_key :assignment_tags, :tags
    add_foreign_key :assignment_tags, :assignments
  end
end
