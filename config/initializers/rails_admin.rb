RailsAdmin.config do |config|
  config.actions do
    dashboard
    index
    new
    export
    history_index
    bulk_delete
    show
    edit
    delete
    history_show
    show_in_app
    nestable
  end

  config.main_app_name = ['VrnElectro', 'Admin']
  config.authorize_with :cancan
  config.current_user_method { current_user } # auto-generated
  config.audit_with :history, 'User'

  config.excluded_models = ['GritterNotice', 'Ckeditor::Asset', 'Ckeditor::AttachmentFile', 'Ckeditor::Picture', 'PaperTrail::Version']

  [:email, :title].each do |method|
    config.label_methods << method
  end

  config.model 'Article' do
    configure :id, :integer 
    configure :title, :string 
    configure :body, :text 
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    configure :ancestry, :string 
    configure :slug, :string 
    list do
      field :id
      field :title
    end
    show do; end
    edit do
      field :title
      field :body, :ck_editor
    end
    export do; end
  end

  config.model 'Category' do
    nestable_tree({
      position_field: :position,
      max_depth: 3
    })
    nestable_list true
    configure :id, :integer 
    configure :parent_id, :enum
    configure :name, :string 
    configure :slug, :string 
    configure :ancestry, :string 
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    object_label_method :name
    list do;
      field :id
      field :name
      field :parent_id
    end
    show do; end
    edit do;
      field :parent_id
      field :name
    end
    export do; end
  end

  config.model 'Photo' do
    visible false
    nestable_list true
    configure :product, :belongs_to_association
    configure :id, :integer 
    configure :product_id, :integer
    configure :image, :carrierwave
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    object_label_method :id
    list do
      field :image 
    end
    show do; end
    edit do
      field :image
    end
    export do; end
  end

  config.model 'Product' do
    nestable_list true
    configure :category, :belongs_to_association
    configure :category_id, :enum
    configure :photos, :has_many_association
    configure :id, :integer 
    configure :lot, :string 
    configure :name, :string 
    configure :description, :text 
    configure :price, :decimal 
    configure :ancestry, :string 
    configure :slug, :string 
    configure :related_products, :enum
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    configure :photos_count, :integer do
      read_only true
    end
    list do
      field :name
      field :price
      field :lot
      field :photos_count
      field :category
    end
    show do; end
    edit do
      field :category_id
      field :lot
      field :name
      field :description, :ck_editor
      field :price
      field :related_products
      field :photos
    end
    export do; end
  end

  config.model 'Price' do
    configure :id, :integer 
    configure :name, :string 
    configure :key, :string 
    configure :file, :carrierwave
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    list do
      field :name
      field :key
    end
    show do; end
    edit do
      field :key
      field :name
      field :file
    end
    export do; end
  end

  config.model 'Role' do
    visible false
    configure :id, :integer 
    configure :name, :string 
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    list do; end
    show do; end
    edit do
      field :name
    end
    export do; end
  end

  config.model 'Slide' do
    nestable_list true
    configure :id, :integer 
    configure :name, :string 
    configure :img, :carrierwave
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    list do
      field :img
      field :name
    end
    show do; end
    edit do
      field :img
      field :name
    end
    export do; end
  end

  config.model 'User' do
    configure :roles do
      inverse_of :users
    end
    configure :id, :integer 
    configure :email, :string 
    configure :password, :password         # Hidden 
    configure :password_confirmation, :password         # Hidden 
    configure :reset_password_token, :string         # Hidden 
    configure :reset_password_sent_at, :datetime 
    configure :remember_created_at, :datetime 
    configure :sign_in_count, :integer 
    configure :current_sign_in_at, :datetime 
    configure :last_sign_in_at, :datetime 
    configure :current_sign_in_ip, :string 
    configure :last_sign_in_ip, :string 
     configure :created_at, :datetime 
    configure :updated_at, :datetime 
    list do
      field :email
      field :sign_in_count
      fields :last_sign_in_at
      field :roles
    end
    show do; end
    edit do
      field :email
      field :password
      field :roles
    end
    export do; end
  end

  config.model 'Order' do
    configure :items, :has_many_association
    configure :id, :integer 
    configure :first_name, :string
    configure :last_name, :string
    configure :phone, :string
    configure :address, :string
    configure :email, :string
    configure :additional, :text
    configure :state, :string
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    list do; end
    show do; end
    edit do
      field :state
    end
    export do; end
  end

  config.model 'Order::Item' do
    visible false
    configure :order, :belongs_to_association
    configure :product, :belongs_to_association
    configure :id, :integer 
    configure :quantity, :integer
    configure :price, :float
    configure :created_at, :datetime 
    configure :updated_at, :datetime 
    list do; end
    show do; end
    edit do
      field :items
    end
    export do; end
  end

end
