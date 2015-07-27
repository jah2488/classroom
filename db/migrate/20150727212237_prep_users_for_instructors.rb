class PrepUsersForInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :user_id, :integer
    add_column :users, :phone, :string
    add_column :users, :name, :string
  end
end
