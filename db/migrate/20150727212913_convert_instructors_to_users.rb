class ConvertInstructorsToUsers < ActiveRecord::Migration
  def up
    Instructor.find_each do |i|
      u = User.find_or_create_by(email: i.email)
      u.password = "1234567890"
      u.encrypted_password = i.encrypted_password
      u.name = i.name
      u.phone = i.phone
      u.confirm!
      i.user_id = u.id
      u.save!
      i.save!
    end
  end
end
