class AddFirstDayToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :first_day, :datetime
  end
end
