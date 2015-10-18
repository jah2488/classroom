class AddArchivedToCohort < ActiveRecord::Migration
  def change
    add_column :cohorts, :archived, :boolean, default: false
  end
end
