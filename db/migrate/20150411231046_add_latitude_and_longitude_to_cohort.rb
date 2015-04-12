class AddLatitudeAndLongitudeToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :latitude, :float
    add_column :cohorts, :longitude, :float
  end
end
