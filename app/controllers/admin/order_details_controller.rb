class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  def update
    @order_detail=OrderDetail.find(params[:id])
    @order=@order_detail.order
    @order_detail.update(order_detail_params)
    if @order_detail.making_status=="in_production"
      @order.update(order_status: 2)
    end
    if @order.order_details.where(making_status: 3).count==@order.order_details.count
      @order.update(order_status: 3)
    end
    redirect_to admin_order_path(@order.id)
  end

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
