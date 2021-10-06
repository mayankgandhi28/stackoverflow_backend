class PostSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:question] = object.question
    data[:user_email] = object&.user&.email
    data
  end

end
