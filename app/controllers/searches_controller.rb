class SearchesController < ApplicationController
  attr_reader :products

  def index
    @products = Product.ransack(name_cont: params[:q]).result distinct: true
    @brands = Brand.desc.all
    respond_to_request
  end

  private

  def respond_to_request
    respond_to do |format|
      format.html{}
      format.json{products}
    end
  end
end
