class Cohort < ActiveRecord::Base
  belongs_to :instructor
  belongs_to :campus
  has_many :students
  has_many :assignments
  has_many :days
  validates :start_time, :name, :campus_id, presence: true

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

  def start_date= val
    self.start_time = val.to_datetime.change(offset: tz_offset).beginning_of_day
  end

  def start_date
    self.start_time.in_time_zone(tz).to_date if self.start_time
  end

  after_create do
    start = DateTime.new(start_date.year, start_date.month, start_date.day, 9, 0, 0).change(offset: tz_offset)
    Day.create!(cohort: self, start: start)
  end

  private

  def tz_offset
     ActiveSupport::TimeZone.new(tz).formatted_offset
  end
end
