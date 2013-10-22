class Photo < ActiveRecord::Base
  #attr_accessible :image, :product_id, :image_cache
  validates :image, presence: true
  has_ancestry
  mount_uploader :image, PhotoUploader
  belongs_to :product

  default_scope -> { order('created_at') }

end
