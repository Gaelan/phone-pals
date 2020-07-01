class HomeController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization

    redirect_to relationships_path if user_signed_in? && current_user.student?

    if user_signed_in? && current_user.organization_member?
      redirect_to organizations_path
    end
  end
end
