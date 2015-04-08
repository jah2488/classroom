class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :amount
      t.text :notes
      t.belongs_to :submission, index: true

      t.timestamps null: false
    end
    add_foreign_key :ratings, :submissions
  end
end
