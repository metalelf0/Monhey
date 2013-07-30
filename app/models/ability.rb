class Ability
  include CanCan::Ability
  
  def initialize(user)
    user ||= User.new # guest user

    can :manage, Expense, :user_id => user.id
    can :manage, Category, :user_id => user.id
  end
end


