class RemoveAbsentFromCheckin < ActiveRecord::Migration
  def change
    remove_column :checkins, :absent, :boolean
    remove_column :checkins, :late, :boolean
  end
end
