class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    if user.admin?
      can :manage, :all
    elsif user.user?
      can :read, :all
      cannot :manage, Task
      can :read, Task
      can [:new, :create, :read], CommentTask
      can [:update, :destroy], AdminUser, :id => user.id
    elsif user.manager?
      cannot :manage, Task
      read :all
    end
  end
end
