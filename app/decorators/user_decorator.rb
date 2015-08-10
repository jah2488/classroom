class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_url(size = 80)
    object.gravatar_url(default: :identicon, size: size, secure: true)
  end
end
