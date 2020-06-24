class CalleePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.student? ? scope.all : scope.where(organization: user.organizations) # TODO SEC not taken
    end
  end

  def index?
    user && user.student?
  end

  def show?
    record.users.include? user
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
