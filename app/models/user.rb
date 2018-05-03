class User < ApplicationRecord
  has_many :watchlists
  has_many :shows, through: :watchlists
  has_many :comments, through: :shows

  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, email: true

end
