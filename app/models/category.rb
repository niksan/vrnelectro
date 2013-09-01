class Category < ActiveRecord::Base
  attr_accessible :name
  has_ancestry
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates :name, presence: true
  default_scope order(:position)
  has_many :products, dependent: :destroy

  class << self
    def for_category(cat)
      includes(products: [:category]).find(cat)
    end
  end

end
