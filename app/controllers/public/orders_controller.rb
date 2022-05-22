class Public::OrdersController < ApplicationController
  def new
    @order=Order.new
  end

  def confirm
  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :order_status)
  end
end
