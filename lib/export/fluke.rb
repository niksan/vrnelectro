class Export::Fluke

  attr_reader :file
  
  MARK = 'fluke'
  BEGIN_ROW = 8
  DEFAULT_PATH = Rails.root.to_s + '/public/fluke.xls'
  CBR_URL = 'http://www.cbr.ru/scripts/XML_daily.asp?'

  def initialize(filepath = DEFAULT_PATH)
    @rur = self.class.euro_course
    @file = Roo::Excel.new(filepath)
  end

  def last_row
    @file.last_row
  end


  def do!
    current_revision_ids = []
    BEGIN_ROW.upto(last_row) do |i|
      row = @file.row(i)
      row_price = row[5].to_f.round(2) * @rur
      if @file.row(i).compact.size > 2
        product = Product.unscoped.fluke.where(lot: row[0]).first
        product = if product
          product.update_attributes(disabled: false) if product.disabled?
          update_product(product, :name, row[1])
          update_product(product, :price, row_price)
          product
        else
          Product.create!(lot: row[0], name: row[1], price: row_price, mark: MARK)
        end
        current_revision_ids << product.id
      end
    end
    on_site_ids = Product.select(:id).fluke.map(&:id)
    Product.where('id IN (?)', (on_site_ids - current_revision_ids)).destroy_all
  end

  class << self

    def do!
      new.do!
    end
    
    def euro_course
      xml = Nokogiri::XML(open(CBR_URL))
      xml.xpath("//Valute[@ID='R01239']//Value").text.gsub(',', '.').to_f
    end

  end

  private
    
    def update_product(product, field, val)
      field = field.to_sym unless field.is_a?(Symbol)
      product.update_attributes(field => val) if product.send(field) != val
    end

end
