class HomeController < ApplicationController
  def index
    skip_policy_scope
    skip_authorization
    if user_signed_in? && current_user.student?
      redirect_to callees_path
    end
    if user_signed_in? && current_user.organization_member?
      redirect_to organizations_path
    end
  end
end
