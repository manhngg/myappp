class LineItemsController < ApplicationController
  before_action :find_item, only: %i(update destroy)
  before_action :find_product, only: :create
  before_action :find_coupon, only: :update

  def update
    return increase(item) if params[:method] == "line_items"
    decrease item
  end

  def create
    @line_item = cart.add_product product
    line_item.price = product.price
    respone_with_js if line_item.save
  end

  def destroy
    item.destroy
    respone_with_js
  end

  private

  attr_reader :line_item, :cart, :item, :product

  def respone_with_js
    respond_to do |format|
      format.js
    end
  end

  def find_product
    @product = Product.find_by id: params[:product_id]

    return if product
    redirect_to root_path
    flash[:danger] = t "product_failed"
  end

  def find_item
    @item = LineItem.find_by id: params[:id]

    return if item
    redirect_to root_path
    flash[:danger] = t "not_exist"
  end

  def increase item
    item.update_attributes quantity: item.quantity + 1
    respond cart
  end

  def decrease item
    quantity = item.quantity - 1

    return if quantity.zero?
    item.update_attributes quantity: quantity
    respond cart
  end

  def respond cart
    respond_to do |format|
      format.html{redirect_to cart}
      format.js
    end
  end
end
