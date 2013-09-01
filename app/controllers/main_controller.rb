class MainController < ApplicationController
  authorize_resource class: 'Product'
  
  def index
    @products = Product.limit(100)
  end

end
