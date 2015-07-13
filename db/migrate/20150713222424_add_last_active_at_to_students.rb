class AddLastActiveAtToStudents < ActiveRecord::Migration
  def change
    add_column :students, :last_active_at, :datetime
  end
end
