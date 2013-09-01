class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_root_categories, :initialize_cart
  
  private
    
    def initialize_cart
      @cart = session[:cart] ||= Cart.new
    end

    def find_root_categories
      @root_categories = Category.roots.order(:position)
    end

end
