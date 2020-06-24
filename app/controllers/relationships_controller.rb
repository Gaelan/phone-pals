class RelationshipsController < ApplicationController
  def create
    callee = Callee.find(params[:callee_id])
    @relationship = Relationship.new(callee: callee, user: current_user)
    authorize @relationship
    @relationship.save!
    redirect_to callee_path(callee)
  end
end
