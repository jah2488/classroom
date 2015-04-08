class Student < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  belongs_to :cohort
  has_many :submissions
  has_many :checkins

  validates_presence_of :cohort
  validates_uniqueness_of :name
  validates_uniqueness_of :github
  validates_uniqueness_of :phone, scope: :name

  def tardies
    checkins.where(late: true).count
  end

  def absences
    checkins.where(absent: true).count
  end

  def to_s
    "#{name} | tardies: #{tardies} | absences: #{absences} | submissions: #{submissions.count}"
  end
end
