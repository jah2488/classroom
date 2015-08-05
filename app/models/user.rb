class User < ActiveRecord::Base
  include Gravtastic
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :instructor
  has_one :student
  has_gravatar

  def instructor?
    !instructor.nil?
  end

  def student?
    !student.nil?
  end

  def to_s
    name || email
  end
end
