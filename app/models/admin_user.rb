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

  def error_tasks
    tasks_error = []
    Task.kind.values.each do |kind|
      tasks.where(kind: kind).ordered.each do |task|
        t = task.previous(self, kind)
        tasks_error.push(t, task) if t.present? && t.to > task.from
      end
    end
    tasks_error
  end

end
