class VoteSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:vote_up] = object.is_up
    data[:vote_down] = object.is_down
    data[:user] = ActiveModelSerializers::SerializableResource.new(object.user, each_serializer: UserSerializer)
    data
  end

end
