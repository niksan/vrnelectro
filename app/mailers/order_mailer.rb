class OrderMailer < ActionMailer::Base
  default from: "Shop.VrnElectro <shop@vrnelectro>"

  def order(order_datas, cart_datas)
    @order_datas = order_datas
    @cart_datas = cart_datas
    mail(to: 'internet36@mail.ru', subject: 'Заказ из интернет-магазина.')
  end

end
