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
      can :manage, [Event, Participation, ParticipationRequest]
      can :read, [Note, User]
      can :manage, Note, from_id: user.id
      can :manage, User, id: user.id
      can [:read, :set_user_language], Language
      can :manage, HiddenEvent, user_id: user.id
    end

    if user.has_role? :fuksi
      can :read, [Event, Participation]
      can [:read, :dokaa, :like_tutor, :dislike_tutor], Note
      can :manage, Note, from_id: user.id
      can :manage, ParticipationRequest, participant_id: user.id
      can :manage, User, id: user.id
      can :read, User
      can [:read, :set_user_language], Language
      can :manage, HiddenEvent, user_id: user.id
    end
  end
end
