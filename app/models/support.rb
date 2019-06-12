class Support
  attr_reader :per_page, :page

  def initialize args = {}
    @page = args[:page]
    @per_page = args[:per_page]
  end

  def users
    @users ||= User.desc.limit(5)
  end

  def brands
    @brands ||= Brand.desc.all
  end

  def products
    @products ||= Product.desc.desc.paginate page: page, per_page: per_page
  end

  def coupons
    @coupons ||= Coupon.all
  end
end
