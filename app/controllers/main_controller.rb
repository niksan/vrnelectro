class MainController < ApplicationController
  authorize_resource class: 'Product'
  
  def index
    @products = Product.main
  end

end
