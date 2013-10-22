class Article < ActiveRecord::Base
  #attr_accessible :body, :title
  has_ancestry
  extend FriendlyId
  friendly_id :title, use: :slugged
  validates :title, presence: true
end
