class Article < ActiveRecord::Base
  has_ancestry
  extend FriendlyId
  friendly_id :title, use: [:history, :finders]
  validates :title, presence: true
end
