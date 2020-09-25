class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :content, presence: true
  has_one_attached :image
end
