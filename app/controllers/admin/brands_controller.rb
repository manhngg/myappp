module Admin
  class BrandsController < Admin::BaseController
    before_action :find_brand, only: %i(show edit update destroy)

    def index
      @brands = Brand.paginate page: params[:page], per_page: Settings.per_page
    end

    def new
      @brand = Brand.new
    end

    def create
      @brand = Brand.new brand_params

      if brand.save
        notice_redirect
      else
        render :new
      end
    end

    def show
      @products = brand.products.desc.paginate page: params[:page],
        per_page: Settings.per_page
    end

    def edit; end

    def update
      @brand = Brand.find_by id: params[:id]

      if brand.update_attributes brand_params
        flash[:success] = t "brand_updated"
        redirect_to admin_brands_url
      else
        render :edit
      end
    end

    def destroy
      brand.destroy
      flash[:success] = t "brand_deleted"
      redirect_to admin_brands_url
    end

    private

    attr_reader :brand

    def notice_redirect
      flash[:info] = t "created_brand"
      redirect_to admin_brands_url
    end

    def brand_params
      params.require(:brand).permit :name
    end

    def find_brand
      @brand = Brand.find_by id: params[:id]

      return if brand
      flash[:success] = t "failed_brand"
      redirect_to root_path
    end
  end
end
