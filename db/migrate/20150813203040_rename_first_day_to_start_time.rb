class RenameFirstDayToStartTime < ActiveRecord::Migration
  def change
    rename_column :cohorts, :first_day, :start_time
  end
end
