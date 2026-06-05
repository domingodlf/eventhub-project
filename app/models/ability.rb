class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Event, status: "published"
    can :read, Category
    can :read, Venue
    can :read, Review

    return if user.blank?

    if user.admin?
      can :manage, :all
    else
      can :read, Event, status: "published"
      can :read, Event, organizer_id: user.id
      can :read, Category
      can :read, Venue
      can :read, Review

      can :read, User, id: user.id

      can :create, Event
      can :update, Event, organizer_id: user.id
      can :publish, Event, organizer_id: user.id, status: "draft"
      can :destroy, Event, organizer_id: user.id, status: ["draft", "published"]

      can :create, Registration
      can :read, Registration, user_id: user.id
      can :cancel, Registration, user_id: user.id

      can :create, Review
    end
  end
end