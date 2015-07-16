class CreateCampus < ActiveRecord::Migration
  def change
    create_table :campus do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
    end
  end
end
