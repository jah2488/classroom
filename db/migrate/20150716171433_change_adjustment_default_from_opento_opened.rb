class ChangeAdjustmentDefaultFromOpentoOpened < ActiveRecord::Migration
  def up
    change_column :adjustments, :state, :string, default: 'OPENED'
  end

  def down
    change_column :adjustments, :state, :string, default: 'OPENED'
  end
end
