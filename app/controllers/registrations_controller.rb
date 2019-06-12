class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit User::ATTRIBUTES_PARAMS
  end

  def account_update_params
    params.require(:user).permit User::UPDATE_PARAMS
  end

  protected

  def update_resource resource, params
    resource.update_without_password params
  end
end
