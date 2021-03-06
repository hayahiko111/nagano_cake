class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
    @cart_items=CartItem.where(customer_id: current_customer.id)
    @total_price=0
    @ordere = Order.new
  end

  def create
    @cart_item=CartItem.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    else
      @cart_item.save
      redirect_to cart_items_path
    end
  end

  def update
    @cart_item=CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
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
