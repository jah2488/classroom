class PrepUsersForStudents < ActiveRecord::Migration
  def change
    add_column :students, :user_id, :integer
    add_column :users, :github, :string
  end
end
