class Comment < ApplicationRecord
  belongs_to :show
  validates :title, presence: true
end
