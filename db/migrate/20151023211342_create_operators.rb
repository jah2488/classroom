class CreateOperators < ActiveRecord::Migration
  def change
    create_table :operators do |t|
      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
