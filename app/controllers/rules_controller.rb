class RulesController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization
  end

  def accept
    skip_authorization
    current_user.update(accepted_rules: true)
    redirect_to root_path
  end
end
