class UsersController < ApplicationController
  before_action :find_user, only: %i(edit show)

  def show
    @orders = user.orders.desc.paginate page: params[:page],
      per_page: Settings.nine
  end

  def edit; end

  private

  attr_reader :user, :orders, :order

  def find_user
    @user = User.find_by id: params[:id]

    return if user
    flash[:success] = t "failed_user"
    redirect_to root_path
  end
end
