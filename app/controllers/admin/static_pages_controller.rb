module Admin
  class StaticPagesController < Admin::BaseController
    before_action :authenticate_user!, only: %i(index)
    before_action :admin_user, only: %i(index)

    def index
      @supports = Support.new
    end

    private

    def admin_user
      redirect_to root_url unless current_user.admin? && current_user
    end
  end
end
