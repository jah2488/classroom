class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :instructor
  has_one :student

  def instructor?
    !instructor.nil?
  end

  def student?
    !student.nil?
  end
end
