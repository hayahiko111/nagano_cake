class Public::CartItemsController < ApplicationController
  def index
    @cart_items=CartItem.where(customer_id: current_customer.id)
  end

  def create
    @cart_item=CartItem.new(cart_item_params)
    if @cart_item.save
      flash[:notice] = "You have created item successfully."
      redirect_to cart_items_path
    else
      redirect_to item_path
    end
  end

  def destroy_one
     @cart_item=CartItem.find(params[:id])
     @cart_item.destroy
     redirect_to cart_items_path
  end

  def destroy_all
    @cart_item=CartItem.all
    @cart_item.destroy_all
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end

end
