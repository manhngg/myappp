class Product < ApplicationRecord
  belongs_to :brand
  has_many :comments, dependent: :destroy
  has_many :line_items, dependent: :destroy
  has_many :item_photos, dependent: :destroy

  validates :brand, presence: true
  validates :name, presence: true, length: {maximum: Settings.name.maximum}
  validates :price, presence: true, numericality: {only_integer: true}
  validates :description, presence: true

  accepts_nested_attributes_for :item_photos,
    reject_if: :all_blank, allow_destroy: true

  mount_uploader :image, ImageUploader

  scope :desc, ->{order created_at: :desc}
  scope :most_bought, (lambda do |_|
    joins("INNER JOIN products ON products.id = product_id")
    .from(LineItem.select("product_id, COUNT(product_id) as count")
    .where.not(order_id: nil).group("product_id")
    .order("count DESC").limit(Settings.ten))
  end)
end
