class ProductCodeMailer < ApplicationMailer
  def product_code order
    @order = order
    mail to: order.email, subject: t("send_product_code")
  end
end
