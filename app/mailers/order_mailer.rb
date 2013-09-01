class OrderMailer < ActionMailer::Base
  default from: "Saller name <saller@domain.com>"

  def order(order_datas, cart_datas)
    @order_datas = order_datas
    @cart_datas = cart_datas
    mail(to: 'test@test.com', subject: 'Заказ из интернет-магазина.')
  end

end
