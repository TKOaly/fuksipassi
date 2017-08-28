class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    can :manage, :callback
    can [:read, :change], Language

    if user.has_role? :admin
      can :manage, :all
    end

    if user.has_role? :tutor
      can :manage, :all
    end

    if user.has_role? :fuksi
      can :read, [Event, Participation]
      can [:read, :dokaa], Note
      can :manage, ParticipationRequest, participant_id: user.id
      can :manage, User, id: user.id
      can [:set_user_language], Language
      can :manage, HiddenEvent, user_id: user.id
    end
  end
end
