class Cart

  attr_reader :items

  def initialize
    @items = []
  end

  def add(product_id, quantity=1)
    current_item = self.item(product_id)
    if current_item
      current_item.increment_quantity(quantity)
    else
      @items << Cart::Item.new(product_id, quantity)
    end
  end

  def price
    @items.sum{ |item| item.price }
  end

  def quantity
    @items.sum{ |item| item.quantity }
  end

  def empty?
    @items.size <= 0
  end

  def empty!
    @items.delete_if { |i| true }
  end

  def delete_item(id)
    @items.delete_if { |item| item.product_id == id.to_i }
  end

  def delete_broken_items
    @items.delete_if { |i| ! !!Product.find(i.product_id) }
  end

  def item(id)
    @items.find { |item| item.product.id == id }
  end

  def to_s
    datas = []
    items.each { |item| datas << item.to_s }
    datas << "Итого: #{price} руб."
    datas
  end

end
