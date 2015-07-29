class ConvertStudentsToUsers < ActiveRecord::Migration
  def up
    Student.find_each do |i|
      u = User.find_or_create_by(email: i.email)
      u.password = "1234567890"
      u.encrypted_password = i.encrypted_password
      u.name = i.name
      u.phone = i.phone
      u.github = i.github
      u.confirm!
      i.user_id = u.id
      u.save!
      i.save!
    end
  end
end
