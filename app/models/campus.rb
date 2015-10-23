class Campus < ActiveRecord::Base
  has_many :cohorts
  has_and_belongs_to_many :operators
  validates :name, :time_zone, presence: true

  def to_s
    self.name
  end

  def students
    cohorts.map(&:students)
  end
end
