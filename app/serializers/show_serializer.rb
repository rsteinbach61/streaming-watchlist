class ShowSerializer < ActiveModel::Serializer
  attributes :id, :show_title, :genre, :show_type, :watchlist_id, :vote
  
  has_many :comments
end
