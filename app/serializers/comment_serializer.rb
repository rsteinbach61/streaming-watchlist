class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :show_id
end
