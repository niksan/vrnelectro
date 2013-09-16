class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :find_root_categories, :initialize_cart, :init_slides, :set_metatags
  
  private
    
    def initialize_cart
      @cart = session[:cart] ||= Cart.new
    end

    def init_slides
      @slides = Slide.all
    end

    def find_root_categories
      @root_categories = Category.roots.order(:position)
    end

    def set_metatags
      @meta_tags = {}
      @meta_tags[:title] = 'Интернет магазин электрики и электротоваров'
    end

end
