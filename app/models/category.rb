class Category < ActiveRecord::Base
  #attr_accessible :name, :parent_id
  has_ancestry cache_depth: true
  extend FriendlyId
  friendly_id :name, use: [:history, :finders]
  validates :name, presence: true
  has_many :products, dependent: :destroy
  default_scope -> { order(:position) }
  before_create :set_last_position!

  def parent_id_enum
    @categories_tree = []
    self.class.roots.each do |cat|
      add_to_tree(cat)
    end
    @categories_tree
  end

  def exclude_current
    except = self.id.nil? ? 0 : self.id
    self.class.where("id != ?", except)
  end

  def set_last_position!
    self.position = if parent_id.to_i > 0
      parent_categories = self.class.unscoped.find(parent_id).children
      parent_categories.empty? ? 1 : parent_categories.order('position').last.position+1
    else
      root_categories = self.class.roots
      root_categories.empty? ? 1 : self.class.unscoped.roots.order('position').last.position+1
    end
  end

  class << self
    def for_category(cat)
      includes(products: [:category]).find(cat)
    end
  end
  
  private

    def add_to_tree(cat)
      dashes = cat.depth > 0 ? ('-' * cat.depth + ' ') : ''
      if cat.id != self.id
        cat_name = (cat.depth == 0) ? "<strong>#{cat.name}</strong>" : cat.name
        @categories_tree << [ dashes + cat_name, cat.id ] 
        cat.children.each { |child| add_to_tree(child) }
      end
    end

end
