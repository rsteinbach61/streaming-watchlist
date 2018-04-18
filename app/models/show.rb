class Show < ApplicationRecord
  belongs_to :watchlist, optional: true
  has_many :users, through: :watchlists
end
