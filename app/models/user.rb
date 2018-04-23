class User < ApplicationRecord

  has_many :shows, through: :watchlists
  has_many :watchlists
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true, email: true

end
