class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :name, :github

  attributes :student?, :instructor?, :operator?

  has_one :student
  has_one :instructor
  has_one :operator
end
