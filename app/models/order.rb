class Order < ApplicationRecord
  before_create :create_code

  belongs_to :user, optional: true
  has_many :line_items, dependent: :destroy

  enum order_status: %i(cancelled processing delivered)

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :phone, :address, presence: true
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}

  scope :desc, ->{order created_at: :desc}

  def add_line_items_from_cart cart
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  class << self
    def generate_code
      (Settings.zero...Settings.eight).map do
        rand(Settings.random..Settings.generate).chr
      end.join
    end
  end

  private

  def create_code
    self.product_code = Order.generate_code
  end
end
