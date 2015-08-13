class Campus < ActiveRecord::Base
  has_many :cohorts
  validates :name, :tz, presence: true

  def to_s
    self.name
  end
end
