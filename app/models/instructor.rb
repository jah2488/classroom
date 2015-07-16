class Instructor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :cohorts

  def current_cohort
    cohorts.last
  end

  def has_office_hours?
    office_hours_start && office_hours_end
  end

  def office_hours_start_at
    office_hours_start.strftime("%H:%M")
  end

  def office_hours_end_at
    office_hours_end.strftime("%H:%M")
  end
end
