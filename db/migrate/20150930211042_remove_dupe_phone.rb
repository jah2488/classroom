class RemoveDupePhone < ActiveRecord::Migration
  def change
    remove_column :students, :phone
  end
end
