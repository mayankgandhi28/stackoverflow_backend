class CommentSerializer < ActiveModel::Serializer
  def attributes(*args)
    data = super
    data[:answers] = object.answers
    data
  end

end
