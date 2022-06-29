class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items

  end

  def update
    @order=Order.find(params[:id])
    @order.update(order_params)
    redirect_to admin_order_path(@order.id)
  end

   private

  def order_params
  params.require(:order).permit(:created_at, :address, :payment_method, :status)
  end


end
