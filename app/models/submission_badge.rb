class SubmissionBadge < ActiveRecord::Base
  belongs_to :badge
  belongs_to :submission
end
