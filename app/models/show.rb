class Show < ApplicationRecord
  belongs_to :watchlist, optional: true
  has_many :users, through: :watchlists
  validates :show_title, presence: true

  scope :genre, ->(genre) {where("genre = ?", genre)}    
end
