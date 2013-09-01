class CategoriesController < ApplicationController
  authorize_resource

  def show
    @category = Category.for_category(params[:id])
  end

end
