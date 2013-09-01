class ProductsController < ApplicationController
  authorize_resource

  def show
    @product = Product.includes(:category, :photos).find(params[:id])
  end
end
