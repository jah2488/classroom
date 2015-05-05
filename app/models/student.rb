class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :cohort
  has_many :submissions
  has_many :checkins

  validates_presence_of :cohort

  def tardies
    checkins.where(late: true).count
  end

  def absences
    checkins.where(absent: true).count
  end

  def completed_assignments
    submissions.where(completed: true)
  end

  def to_s
    "#{(name || email)} | tardies: #{tardies} | absences: #{absences} | submissions: #{submissions.count}"
  end
end
