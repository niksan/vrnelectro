class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id
  has_ancestry
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true
  default_scope order(:position)
  has_many :products, dependent: :destroy

  def parent_id_enum
    except = self.id.nil? ? 0 : self.id
    self.class.where("id != ?", except).map { |c| [ c.name, c.id ] }
  end

  class << self
    def for_category(cat)
      includes(products: [:category]).find(cat)
    end
  end

end
