class Tag < ActiveRecord::Base
  has_many :assignment_tags
  has_many :assignments, through: :assignment_tags
  validates_uniqueness_of :name
end
