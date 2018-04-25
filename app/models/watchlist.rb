class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :shows
  validates :title, presence: true
end
