class AssignmentTag < ActiveRecord::Base
  belongs_to :tag,        inverse_of: :assignment_tags
  belongs_to :assignment, inverse_of: :assignment_tags
end
