class Rating < ActiveRecord::Base
  belongs_to :submission

  def has_feedback?
    @has_feedback ||= notes.length > 1
  end
end
