class Campus < ActiveRecord::Base
  has_many :cohorts
  validates :name, :time_zone, presence: true

  def to_s
    self.name
  end
end
