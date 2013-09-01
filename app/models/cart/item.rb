class Cart::Item

  attr_reader :product_id
  attr_accessor :quantity

  def initialize(product_id, quantity=1)
    @product_id = product_id
    @quantity = quantity.to_i
  end

  def product
    begin
      Product.find(self.product_id)
    rescue ActiveRecord::RecordNotFound
      Product.new(name: 'Error! This item not found.')
    end
  end

  def increment_quantity(quantity)
    @quantity += quantity
  end

  def name
    product.name
  end

  def price
    product.price * @quantity.to_i
  end

  def to_s
    "#{product.name}, #{quantity} шт. , #{price} руб."
  end

end
