class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
       can :manage, :all
    end

    if user.has_role? :fuksi
      can :read, Event
      can [:read, :create, :update, :destroy], [Participation, Note]
      can [:read, :create, :update, :destroy], User, id: user.id
    end
  end
end
