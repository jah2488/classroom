class UserDecorator < Draper::Decorator
  delegate_all

  def avatar_url
    gravatar_id = Digest::MD5.hexdigest(object.email.downcase)
    "http://gravatar.com/avatar/#{gravatar_id}.png?"
  end
end
