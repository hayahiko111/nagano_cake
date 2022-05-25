class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
    @address=Address.where(customer_id: current_customer.id)
  end

  def confirm
    @address=Address.where(customer_id: current_customer.id)
    @order=Order.new(order_params)
    if params[:order][:select_address].to_i == 0
      @order.postal_code=current_customer.postal_code
      @order.address=current_customer.address
      @order.name=current_customer.first_name+current_customer.last_name
    elsif params[:order][:select_address].to_i == 1
      @address=@address.find(params[:order][:address_id])
      @order.postal_code=@address.postal_code
      @order.address=@address.address
      @order.name=@address.name
    end
  end

  def create
    @cart_item=CartItem.where(customer_id: current_customer.id)
    @order=Order.new(order_params)
    if @order=Order.save
      @order_detail=OrderDetail.new
      
      redirect_to orders_complete_path
    else
      render:confirm
    end
  end

  def complete

  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :payment_method, :shipping_cost, :total_payment)
  end
end
