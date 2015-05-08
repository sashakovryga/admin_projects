class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :manage, Task
      can [:update, :destroy], AdminUser, :id => user.id
      can :read, :all
    elsif user.manager?
      read :all
    end
  end
end
