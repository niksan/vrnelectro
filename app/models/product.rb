class Product < ActiveRecord::Base
  #attr_accessible :description, :lot, :name, :price, :related_products, :category_id, :photos_attributes, :remove_image, :disabled, :mark
  validates :name, :price, presence: true
  validates :lot, uniqueness: true, allow_blank: true
  has_ancestry
  extend FriendlyId
  friendly_id :name, use: [:history, :finders]
  serialize :related_products, Array
  has_many :photos, dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :photos, allow_destroy: true
  has_paper_trail
  
  default_scope -> { where(disabled: false).order('category_id, price, name') }
  scope :iek, -> { where(mark: 'iek') }
  scope :fluke, -> { where(mark: 'fluke') }
  scope :main, -> { where(show_on_main: true) }
  
  def category_id_enum
    Category.new.parent_id_enum 
  end
  
  def related_products_enum
    Product.order(:name).map { |p| [p.name, p.id] }
  end

  def disabled?
    disabled
  end

  def related
    self[:related_products][1..-1] ? self.class.includes(:category).find(self[:related_products][1..-1]) : []
  end

  def has_related?
    related.size > 0
  end

  def photos_count
    photos.count
  end

  def main_photo
    photos.first.try(:image) || false
  end

  def photos?
    photos.size > 0
  end

  def more_photos?
    photos.size > 1
  end

  def more_photos
    photos[1..-1]
  end

  def destroy
    update_attributes(disabled: true)
  end
  alias destroy! destroy

  def super_destroy!
    self.class.superclass.instance_method(:destroy).bind(self).call
  end

  class << self
    def super_destroy_all!
      self.unscoped.all.each { |p| p.super_destroy! }
    end
  end

end
