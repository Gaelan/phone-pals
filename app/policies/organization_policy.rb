class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all
      else
        scope.merge(user.organizations)
      end
    end
  end

  def index?
    user != nil
  end

  def show?
    user && (user.admin? || record.users.include?(user) )
  end

  def new?
    user && user.admin?
  end

  def create?
    user && user.admin?
  end
end