class Watchlist < ApplicationRecord
  belongs_to :user
  has_many :shows
end
