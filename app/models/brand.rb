class Brand < ApplicationRecord
  has_many :products, dependent: :destroy
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  scope :desc, ->{order created_at: :desc}
end
