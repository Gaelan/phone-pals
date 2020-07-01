class RelationshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user && user.student?
  end

  def new?
    user && user.student? && user.can_start_relationship?
  end

  def create?
    user == record.user && record.user.student? &&
      record.user.can_start_relationship? &&
      record.callee.can_start_relationship?
  end
end
