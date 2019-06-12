class OrdersController < ApplicationController
  before_action :current_cart, only: %i(new create)
  before_action :find_order, only: %i(show update)
  before_action :find_order_product_code, only: :edit
  before_action :create_order, only: :create
  before_action :find_coupon, only: %i(new create)

  def new
    @support_order = SupportOrder.new order:
      Order.new(coupon_code: session[:coupon_code])
  end

  def create
    order.add_line_items_from_cart cart

    if order.save
      coupon.update_attributes imported: coupon.imported += 1 if coupon
      create_success
      create_notification order
    else
      render :new
    end
  end

  def show
    @support_coupon = SupportCoupon.new order: order
    user_signed_in? ? current_order : redirect_to(root_path)
  end

  def edit
    @support_coupon = SupportCoupon.new order: order
  end

  def update
    order.update_attributes order_status: :cancelled if order.processing?
    redirect_to order
  end

  private

  attr_reader :cart, :order, :line_items, :line_item,
    :order_product_code, :coupon

  def current_order
    return if current_user.orders.find_by id: params[:id]
    redirect_to root_path
  end

  def find_order_product_code
    @order = Order.find_by id: params[:id],
      product_code: params[:product_code]
    failed_order
  end

  def find_order
    @order = Order.find_by id: params[:id]
    failed_order
  end

  def failed_order
    return if order
    flash[:warning] = t "failed_order"
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit :name, :email, :address, :phone
  end

  def create_order
    @order = if current_user
               current_user.orders.build order_params
             else
               Order.new order_params
             end
    order.coupon_code = session[:coupon_code]
    @support_order = SupportOrder.new order: order
  end

  def create_success
    Cart.destroy session[:cart_id]
    clear_session
    redirect_to order
    flash[:success] = current_user ? t("thank") : t("check")
  end

  def create_notification order
    SendEmailWorker.perform_at(Time.zone.now + 20.seconds, order.id)
    Notification.create content: "new_order", order_url: admin_order_path(order)
    ActionCable.server.broadcast "notification_channel", message: "success"
  end

  def clear_session
    session.delete :coupon_code
    session[:cart_id] = nil
  end
end
