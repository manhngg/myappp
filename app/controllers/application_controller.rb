class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include CurrentCart

  before_action :set_locale
  before_action :current_cart

  class << self
    def default_url_options
      {locale: I18n.locale}
    end
  end

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def force_json
    request.format = :json
  end

  def find_coupon
    coupon = session[:coupon_code]

    return unless coupon
    @coupon = Coupon.find_by code: coupon
  end
end
