class BadgeDecorator < Draper::Decorator
  delegate_all
  
  def image_tag
    h.image_tag(h.attachment_url(object, :icon_image, :fill, 100, 100, format: 'png'), class: "circle")
  end
end
