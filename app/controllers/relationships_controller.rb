class RelationshipsController < ApplicationController
  before_action :check_rules

  def index
    skip_policy_scope
    authorize Relationship

    @callees = current_user.callees
    redirect_to new_relationship_path if @callees.empty?
  end

  def new
    authorize Relationship

    @callees = policy_scope(Callee) # TODO: limit to available folks in the query, not in code
    @callees = @callees.select &:can_start_relationship?
  end

  def create
    callee = Callee.find(params[:callee_id])
    @relationship = Relationship.new(callee: callee, user: current_user)
    authorize @relationship

    @relationship.save!
    redirect_to callee_path(callee)
  end

  protected

  def check_rules
    unless current_user.accepted_rules?
      skip_authorization
      skip_policy_scope
      redirect_to rules_path
    end
  end
end
