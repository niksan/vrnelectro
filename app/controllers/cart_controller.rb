class CartController < ApplicationController

  def index
    if @cart.empty?
      gflash warning: t('cart.empty')
      redirect_to root_path
    end
  end

  def update
    params[:cart_items].each do |item, quantity|
      current_item = @cart.item(item.to_i)
      @cart.items.delete(current_item) if quantity.to_i == 0
      current_item.quantity = quantity.to_i if current_item
    end
    gflash notice: t('cart.updated')
    redirect_to cart_index_path
  end

end
