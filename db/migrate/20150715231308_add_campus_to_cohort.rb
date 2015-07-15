class AddCampusToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :campus_id, :integer
    remove_column :cohorts, :latitude
    remove_column :cohorts, :longitude
    remove_column :cohorts, :location
  end
end
