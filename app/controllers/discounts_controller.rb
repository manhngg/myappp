class DiscountsController < ApplicationController
  before_action :find_coupon, only: :update

  def update
    session[:coupon_code] = coupon.code
    flash[:success] = t "coupon_success"
  end

  private

  attr_reader :coupon

  def find_coupon
    @coupon = Coupon.find_by code: params[:id]

    if coupon.blank?
      react_with_invalid_coupon
    else
      unless coupon.unfull_import? && coupon.unexpired?
        react_with_invalid_coupon
      end
    end
  end

  def react_with_invalid_coupon
    session.delete :coupon_code
    render json: {errors: true}, status: 400
    flash[:danger] = t "coupon_invalid"
  end
end
