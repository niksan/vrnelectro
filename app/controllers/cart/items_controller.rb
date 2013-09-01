class Cart::ItemsController < ApplicationController

  def create
    @cart.add(Product.find(params[:id]).id)
  end  

end
