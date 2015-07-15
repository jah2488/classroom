class AddStartToDay < ActiveRecord::Migration
  def change
    add_column :days, :start, :datetime
    remove_column :days, :start_time
  end
end
