class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :update, :destroy, to: :modify

    can :manage, :all if user.is_admin?
    can [:read, :create], Topic
    can :modify, Topic, student_id: user.id

  end
end
