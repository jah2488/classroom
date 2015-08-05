class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_url
    object.gravatar_url(default: :identicon, size: 80, secure: true)
  end
end
