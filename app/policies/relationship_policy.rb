class RelationshipPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user == record.user && record.user.student? &&
      record.user.can_start_relationship? &&
      record.callee.can_start_relationship?
  end
end
