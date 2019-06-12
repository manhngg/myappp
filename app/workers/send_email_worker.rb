class SendEmailWorker
  include Sidekiq::Worker

  def perform order
    @order = Order.find_by id: order.id
    ProductCodeMailer.product_code(@order).deliver_now
  end
end
