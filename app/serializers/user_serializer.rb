class UserSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:token] = object.auth_token
    data[:id] = object.id
    data[:first_name] = object.first_name ? object.first_name : ""
    data[:last_name] = object.last_name ? object.last_name : ""
    data[:email] = object.email ? object.email : ""
    data[:posts] = ActiveModelSerializers::SerializableResource.new(object.posts, each_serializer: PostsSerializer)
    data
  end

end
