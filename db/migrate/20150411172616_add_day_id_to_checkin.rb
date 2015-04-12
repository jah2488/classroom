class AddDayIdToCheckin < ActiveRecord::Migration
  def change
    add_reference :checkins, :day, index: true
    add_foreign_key :checkins, :days
  end
end
