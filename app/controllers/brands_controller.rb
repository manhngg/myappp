class BrandsController < ApplicationController
  attr_reader :brand

  before_action :find_brand, only: %i(show)

  def index
    @brands = Brand.desc.paginate page: params[:page]
  end

  def show
    @brands = Brand.desc.all
  end

  private

  def find_brand
    @brand = Brand.find_by id: params[:id]

    return if brand
    flash[:success] = t "failed_brand"
    redirect_to root_path
  end
end
