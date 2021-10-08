class CommentSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:answers] = object.answers
    data[:votes] = ActiveModelSerializers::SerializableResource.new(object.votes, each_serializer: VotesSerializer)
    data
  end

end
