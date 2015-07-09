class AssignmentTag < ActiveRecord::Base
  belongs_to :tag, inverse_of: :assignment_tags
  belongs_to :assignment, inverse_of: :assignment_tags
  validates_presence_of :assignment_id, :tag_id
end
