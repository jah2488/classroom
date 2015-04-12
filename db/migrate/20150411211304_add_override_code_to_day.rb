class AddOverrideCodeToDay < ActiveRecord::Migration
  def change
    add_column :days, :override_code, :string, null: false, default: SecureRandom.hex(2)
  end
end
