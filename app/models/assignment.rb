class Assignment < ActiveRecord::Base
  belongs_to :cohort
  has_many :submissions

  def to_s
    "Title: #{title} | Due: #{due_date}"
  end
end
