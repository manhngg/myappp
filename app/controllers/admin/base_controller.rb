module Admin
  class BaseController < ApplicationController
    layout "admin"

    before_action :admin_user

    def admin_user
      redirect_to root_url unless current_user && current_user.admin?
    end
  end
end
