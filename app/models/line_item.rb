class LineItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart, optional: true
  belongs_to :order, optional: true

  scope :desc, ->{order created_at: :desc}

  def total_price
    product.price * quantity
  end

  def remain_price
    coupon = Coupon.find_by code: order.coupon_code
    return total_price unless coupon
    total_price * (100 - coupon.percent) / 100
  end

  def sale_price
    total_price - remain_price
  end
end
