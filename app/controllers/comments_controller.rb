class CommentsController < ApplicationController
  before_action :correct_user, only: %i(destroy)
  before_action :find_product, only: %i(create destroy)

  def new; end

  def create
    @comment = product.comments.build comment_params.merge(user:
      current_user)

    if comment.save
      handle_create_comment_success
    else
      handle_create_comment_failed
    end
  end

  def destroy
    comment.destroy
    flash[:success] = t "comment_deleted"
    redirect_to request.referer || root_url
  end

  private

  attr_reader :comment, :product

  def find_product
    @product = Product.find_by id: params[:product_id]

    return if product
    flash[:success] = t "failed_product"
    redirect_to root_path
  end

  def comment_params
    params.require(:comment).permit :description
  end

  def handle_create_comment_success
    flash[:success] = t "comment_created"
    redirect_to product
  end

  def handle_create_comment_failed
    flash[:warning] = t "comment_failed"
    redirect_to product
  end

  def correct_user
    @comment = current_user.comments.find_by id: params[:id]
    redirect_to root_url unless comment
  end
end
