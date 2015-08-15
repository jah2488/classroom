class Cohort < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :campus
  has_many :students
  has_many :assignments
  has_many :days
  validates :start_time, :name, :campus_id, presence: true

  after_create :create_first_day

  def tz
    campus.tz if campus
  end

  def days_by_month
    days.group_by{ |d| d.start.month }.each do |month|
      yield DayDecorator.decorate_collection(month[1])
    end
  end

  def current_day
    time = DateTime.now.in_time_zone(tz)
    days.find_by("start >= ? AND start < ?", time.beginning_of_day, time.end_of_day)
  end

  def first_day
    days.order(:start).first
  end

  def ungraded_submissions
    Submission.ungraded_for self
  end

  def start_time
    time = read_attribute(:start_time)
    time.in_time_zone(tz) if time && tz
  end

  def start_time= val
    write_attribute(:start_time, val.in_time_zone(tz).beginning_of_day)
  end

  private

  def create_first_day
    day = Day.new
    day.cohort = self
    day.start  = self.start_time.change(hour: 9)
    day.save
  end
end
