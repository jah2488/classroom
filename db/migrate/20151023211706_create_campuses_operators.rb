class CreateCampusesOperators < ActiveRecord::Migration
  def change
    create_table :campuses_operators do |t|
      t.integer :campus_id
      t.integer :operator_id
    end
  end
end
