class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order=Order.new
    @address=Address.where(customer_id: current_customer.id)
  end

  def confirm
    @order=Order.new
    @address=Address.where(customer_id: current_customer.id)
    @cart_item=CartItem.where(customer_id: current_customer.id)
    @order.shipping_cost=800
    @order.payment_method = params[:order][:payment_method]
    if params[:order][:select_address].to_i == 0
      @order.postal_code=current_customer.postal_code
      @order.address=current_customer.address
      @order.name=current_customer.last_name+current_customer.first_name
    elsif params[:order][:select_address].to_i == 1
      @address=@address.find(params[:order][:address_id])
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
    end
  end

  def create
    @order=Order.new(order_params)
    @cart_item=CartItem.where(customer_id: current_customer.id)
    if @order.save
      @cart_item.each do |c_item|
        @order_detail=OrderDetail.new
        @order_detail.item_id = c_item.item_id
        @order_detail.amount = c_item.amount
        @order_detail.price = c_item.item.with_tax_price
        @order_detail.order_id = @order.id
        @order_detail.save
      end
      @cart_item.destroy_all
      redirect_to complete_orders_path
    end
  end

  def complete
  end

  def index
    @orders=Order.where(customer_id: current_customer.id)
  end

  def show
    @order=Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :shipping_cost, :total_payment)
  end
end
