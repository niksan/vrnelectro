class Export::Iek
  
  BEGIN_ROW = 8
  DEFAULT_PATH = Rails.root.to_s + '/public/iek.xlsx'

  attr_reader :file
  
  def initialize(filepath = DEFAULT_PATH)
    @file = Roo::Excelx.new(filepath)
  end

  def last_row
    @file.last_row
  end

  def do!
    BEGIN_ROW.upto(last_row) do |i|
      row = @file.row(i)
      if @file.row(i).compact.size > 2
        product = Product.new(lot: row[0], name: row[1], price: row[5].to_f.round(2))
        raise "Can't save product #{product.inspect} \n #{i}" unless product.save
        puts "#{product.id} #{product.name}"
      end
    end
  end

  def self.do!
    new.do!
  end

end
