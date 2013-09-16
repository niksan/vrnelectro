class Slide < ActiveRecord::Base
  attr_accessible :img, :img_cache, :remove_img, :name
  validates :img, presence: true
  has_ancestry
  mount_uploader :img, SlideUploader
  default_scope order(:position)
end
