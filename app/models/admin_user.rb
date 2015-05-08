class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :tasks
  extend Enumerize
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  enumerize :role, in: %w(admin user manager)

  def admin?
    role.to_sym == :admin
  end

  def user?
    role.to_sym == :user
  end

  def manager?
    role.to_sym == :manager
  end
end
