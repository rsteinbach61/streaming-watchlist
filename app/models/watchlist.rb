class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :shows, dependent: :delete_all
  validates :title, presence: true
end
