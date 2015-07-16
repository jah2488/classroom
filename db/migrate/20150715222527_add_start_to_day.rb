class AddStartToDay < ActiveRecord::Migration
  def up
    add_column :days, :start, :datetime, default: Time.now
    Day.find_each do |d|
      d.start = d.start_time.to_datetime if d.start_time
    end
    remove_column :days, :start_time
  end

  def down
    add_column :days, :start_time, :time
    Day.find_each do |d|
      d.start_time = d.start.to_time if d.start
    end
    remove_column :days, :start
  end
end
