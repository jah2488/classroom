class AddOverrideCodeToDay < ActiveRecord::Migration
  def change
    add_column :days, :override_code, :string, null: false, default: 'd80c'
  end
end
