class OrdersController < ApplicationController

  def new; end

  def create
    begin
      ActiveRecord::Base.transaction do
        @order = Order.new(params[:order])
        @order.save!
       create_order_items!
        OrderMailer.order(get_order_datas(params[:order]), @cart.to_s).deliver
        @cart.empty!
      end
      gflash success: t('order.save.success')
      redirect_to root_path
     rescue
       gflash error: t('order.save.error')
       render :new
     end
   end

   private
    
    def create_order_items!
      @cart.items.each do |item|
        Order::Item.create!(product_id: item.product_id,
                            quantity: item.quantity,
                            price: item.price,
                            order_id: @order.id)
      end
    end
  
    def get_order_datas(params)
      datas = {}
      params.each do |k, v|
        datas[t(".orders.new.#{k}")] = v
      end
      datas
    end

end
