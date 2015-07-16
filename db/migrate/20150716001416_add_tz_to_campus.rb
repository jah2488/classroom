class AddTzToCampus < ActiveRecord::Migration
  def change
    add_column :campus, :tz, :string, default: "Central Time (US & Canada)"
  end
end
