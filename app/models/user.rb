class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_ids, :roles_attributes
  has_and_belongs_to_many :roles

  def role?(role)
    !!self.roles.find_by_name(role.to_s.downcase)
  end

end
