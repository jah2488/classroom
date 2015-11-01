class User < ActiveRecord::Base
  include Gravtastic
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
    :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :instructor
  has_one :student
  has_one :operator
  has_gravatar

  def self.search(current_user, query)
    if current_user.staff?
      User.where("email ILIKE (?) OR name ILIKE (?)", "%#{query}%", "%#{query}%")
    else
      [current_user]
    end
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data["email"])
    unless user
      user = User.create!(name: data["name"], email: data["email"], password: Devise.friendly_token[0,20])
      user.confirm!

      if Mail::Address.new(user.email).domain == "theironyard.com"
        Instructor.create(user_id: user.id)
      end
    end
    user
  end

  def instructor?
    !instructor.nil?
  end

  def student?
    !student.nil?
  end

  def operator?
    !operator.nil?
  end

  def staff?
    instructor? || operator?
  end

  def in_cohort? cohort
    return true if self.instructor? && self.instructor.cohorts.include?(cohort)
    return true if self.operator? && self.operator.campuses.include?(cohort.campus)
    return true if self.student? && self.student.cohort == cohort
    false
  end

  def has_student? stuent
    return true if self.instructor? && self.instructor.has_student?(student)
    return true if self.operator? && self.operator.has_student?(student)
    return true if self.student? && self.student == student
    false
  end

  def to_s
    name || email
  end
end
