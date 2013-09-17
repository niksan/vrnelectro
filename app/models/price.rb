class Price < ActiveRecord::Base
  attr_accessible :file, :file_cache, :remove_file, :key, :name
  validates :key, presence: true
  validates :name, presence: true
  validates :file, presence: true
  mount_uploader :image, PriceUploader
  default_scope order(:name)
end
