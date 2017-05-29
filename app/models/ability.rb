class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :manage, :callback

    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :fuksi
      can :read, [Event, Participation]
      can [:read, :dokaa], Note
      can :manage, ParticipationRequest
      can :manage, User, id: user.id
    end
  end
end
