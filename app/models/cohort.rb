class Cohort < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :campus
  has_many :students
  has_many :assignments
  has_many :days
  validates :first_day, presence: true
  validates :campus_id, presence: true

  after_create :create_first_day

  def tz
    campus.tz
  end
  private

  def create_first_day
    day = Day.new
    day.cohort = self
    day.start = self.first_day.change hour: 9
  end
end
