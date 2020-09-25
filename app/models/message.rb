class Message < ApplicationRecord
  belongs_to :room
  belongs_to :user
  validates :content, presence: true, unless: :was_attached?
  def was_attached?
    self.image.attached?
  end
  has_one_attached :image
end
