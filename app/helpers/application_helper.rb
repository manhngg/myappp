module ApplicationHelper
  def full_title page_title = ""
    @base_title = t "mobile_shop"
    page_title.empty? ? @base_title : page_title + " | " + @base_title
  end

  def cart_size
    current_cart = Cart.find_by id: session[:cart_id]
    current_cart ? current_cart.line_items.size : nil
  end
end
