class AddStartToAssignments < ActiveRecord::Migration
  def up
    add_column :assignments, :start_at, :datetime
    execute 'alter table assignments alter column start_at set default now()'
  end

  def down
    remove_column :assignments, :start_at
  end
end
