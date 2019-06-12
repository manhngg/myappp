class SupportCoupon
  attr_reader :order, :coupon

  def initialize args = {}
    @order = args[:order]
    @coupon = Coupon.find_by code: order.coupon_code
  end

  def line_items
    @line_items ||= order.line_items
  end

  def show_price arg
    price_count = "#{arg}_price"
    order.line_items.inject(0) do |sum, price|
      sum + price.send(price_count)
    end
  end
end
