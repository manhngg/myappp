class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :description, presence: true, length: {maximum: Settings.maximum}

  scope :desc, ->{order created_at: :desc}
end
