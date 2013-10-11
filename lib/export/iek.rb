class Export::Iek

  attr_reader :file
  
  MARK = 'iek'
  BEGIN_ROW = 8
  DEFAULT_PATH = Rails.root.to_s + '/public/iek.xlsx'

  def initialize(filepath = DEFAULT_PATH)
    @file = Roo::Excelx.new(filepath)
  end

  def last_row
    @file.last_row
  end

  def do!
    current_revision_ids = []
    BEGIN_ROW.upto(last_row) do |i|
      row = @file.row(i)
      if @file.row(i).compact.size > 2
        product = Product.unscoped.iek.where(lot: row[0]).first
        product = if product
          product.update_attributes(disabled: false) if product.disabled?
          update_product(product, :name, row[1])
          update_product(product, :price, row[5].to_f.round(2))
          product
        else
          Product.create!(lot: row[0], name: row[1], price: row[5].to_f.round(2), mark: MARK)
        end
        current_revision_ids << product.id
      end
    end
    on_site_ids = Product.select(:id).iek.map(&:id)
    Product.where('id IN (?)', (on_site_ids - current_revision_ids)).destroy_all
  end

  def self.do!
    new.do!
  end

  private
    
    def update_product(product, field, val)
      field = field.to_sym unless field.is_a?(Symbol)
      product.update_attributes(field => val) if product.send(field) != val
    end

end
