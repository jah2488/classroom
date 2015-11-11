class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :github

  attributes :student?, :instructor?, :operator?
  attributes :avatar_url

  has_one :student
  has_one :instructor
  has_one :operator

  def avatar_url
    object.gravatar_url(default: :identicon, size: 80, secure: true)
  end
end
