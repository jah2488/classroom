class Badge < ActiveRecord::Base
  attachment :icon_image
  has_many :submission_badges
  has_many :submissions, through: :submission_badges

  def as_hash(view_context)
    self.attributes.merge({ icon_image: view_context.attachment_url(self, :icon_image, :fill, 100, 100, format: :png) })
  end
end
