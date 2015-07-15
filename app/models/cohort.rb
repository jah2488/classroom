class Cohort < ActiveRecord::Base
  belongs_to :instructor
  has_many :students
  has_many :assignments
  has_many :days
  validates :first_day, presence: true

  after_create :create_first_day

  private

  def create_first_day
    day = Day.new
    day.cohort = self
    day.start_time = self.first_day.change hour: 9
  end
end
