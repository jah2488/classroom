class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.string :name
      t.text :description
      t.string :icon_image_id

      t.timestamps null: false
    end
  end
end
