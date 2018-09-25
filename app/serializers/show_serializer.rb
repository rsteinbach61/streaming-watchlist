class ShowSerializer < ActiveModel::Serializer
  attributes :id, :show_title, :genre, :show_type, :watchlist_id
  has_many :comments
end
