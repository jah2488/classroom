class Badge < ActiveRecord::Base
  attachment :icon_image
  has_many :submission_badges
  has_many :submissions, through: :submission_badges
end
