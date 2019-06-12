class SupportOrder
  attr_reader :order, :coupon

  def initialize args
    @order = args[:order]
    @coupon = Coupon.find_by code: order.coupon_code
  end
end
