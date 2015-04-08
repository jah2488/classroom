class AddAttachmentAvatarToStudents < ActiveRecord::Migration
  def self.up
    change_table :students do |t|
      t.attachment :avatar
    end
  end

  def self.down
    remove_attachment :students, :avatar
  end
end
