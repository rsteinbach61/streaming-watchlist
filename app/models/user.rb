class User < ApplicationRecord
  validates :name, presence: true
  has_many :shows, through: :watchlists
  has_many :watchlists
  has_secure_password

end
