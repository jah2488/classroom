class StudentSerializer < ActiveModel::Serializer
  attributes :id, :blog, :bio, :twitter, :last_active_at, :created_at, :updated_at, :pretty_name
  belongs_to :cohort
  belongs_to :user

  def pretty_name
    object.decorate.pretty_name
  end
end
