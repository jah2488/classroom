class RenameTzOnCampus < ActiveRecord::Migration
  def change
    rename_column :campuses, :tz, :time_zone
  end
end
