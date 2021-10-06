class PostSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:question] = object.question
    data[:user] = ActiveModelSerializers::SerializableResource.new(object.user, each_serializer: UserSerializer)
    data[:comments] = ActiveModelSerializers::SerializableResource.new(object.comments, each_serializer: CommentSerializer)
    data
  end

end
