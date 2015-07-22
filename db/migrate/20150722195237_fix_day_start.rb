class FixDayStart < ActiveRecord::Migration
  def change
    change_column_default :days, :start, nil
  end
end
