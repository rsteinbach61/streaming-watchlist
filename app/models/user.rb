class User < ApplicationRecord
  has_many :watchlists
  has_many :shows, through: :watchlists
  has_many :comments, through: :shows

  has_secure_password
  validates :name, presence: true, uniqueness: true
  validates :email, presence: true, email: true

  def self.find_or_create_by_omniauth(auth)

    @user = User.find_or_create_by(uid: auth['uid']) do |u|
      u.name = auth['info']['name']
      u.email = auth['info']['email']
      u.password = SecureRandom.hex
      u.save
    end

  end

end
