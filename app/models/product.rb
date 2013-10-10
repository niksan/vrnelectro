class Product < ActiveRecord::Base
  attr_accessible :description, :lot, :name, :price, :related_products, :category_id, :photos_attributes, :remove_image, :disabled
  validates :name, :price, presence: true
  validates :lot, uniqueness: true, allow_blank: true
  has_ancestry
  extend FriendlyId
  friendly_id :name, use: :slugged
  serialize :related_products, Array
  has_many :photos, dependent: :destroy
  belongs_to :category
  accepts_nested_attributes_for :photos, allow_destroy: true
  
  default_scope where(disabled: false).order('category_id, price, name')
  
  def related_products_enum
    Product.order(:name).map { |p| [p.name, p.id] }
  end

  def related
    self.class.includes(:category).find(self[:related_products][1..-1])
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

end
