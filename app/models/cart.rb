class Cart < ApplicationRecord
  has_many :line_items, dependent: :destroy

  def current_cart? cart
    self == cart
  end

  def add_product product
    product_id = product.id
    line_item = line_items.find_by product_id: product_id

    if (current_item = line_item)
      current_item.quantity += 1
    else
      current_item = line_items.build product_id: product_id
    end
    current_item
  end

  def total_price
    line_items.to_a.sum(&:total_price)
  end

  def remain_price coupon
    return total_price unless coupon
    total_price * (100 - coupon.percent) / 100
  end

  def sale_price coupon
    total_price - remain_price(coupon)
  end
end
