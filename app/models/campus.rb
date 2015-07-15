class Campus < ActiveRecord::Base
  has_many :cohorts
  validates :name, presence: true

  def to_s
    self.name
  end
end
