class Show < ApplicationRecord
  belongs_to :watchlist, optional: true
  has_many :comments, dependent: :delete_all
  validates :show_title, :show_type, :watchlist_id, presence: true
  accepts_nested_attributes_for :comments
  
  scope :genre, ->(genre) {where("genre = ?", genre)}
  scope :show_type, ->(show_type) {where("show_type = ?", show_type)}

end
