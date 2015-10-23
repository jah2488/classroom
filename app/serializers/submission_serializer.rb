class SubmissionSerializer < ActiveModel::Serializer
  attributes :id, :completed, :created_at, :updated_at, :late, :link, :notes, :on_time, :graded
  belongs_to :assignment
  belongs_to :student

  def graded
    object.graded?
  end
end
