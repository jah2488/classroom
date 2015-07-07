class CreateAdjustments < ActiveRecord::Migration
  def change
    create_table :adjustments do |t|
      t.belongs_to :checkin, index: true
      t.string :state, default: 'OPEN'

      t.timestamps null: false
    end
    add_foreign_key :adjustments, :checkins
  end
end
