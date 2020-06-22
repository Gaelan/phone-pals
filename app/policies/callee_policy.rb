class CalleePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.student?
        scope.all # TODO SEC not taken
      else
        scope.where(organization: user.organizations)
      end
    end
  end

  def index?
    user && user.student?
  end

  def new?
    user && (user.admin? || record.organization.users.include?(user))
  end
  
  def create?
    user && (user.admin? || record.organization.users.include?(user))
  end

  def edit?
    user && (user.admin? || record.organization.users.include?(user))
  end

  def update?
    user && (user.admin? || record.organization.users.include?(user))
  end

  def destroy?
    user && (user.admin? || record.organization.users.include?(user))
  end
end
