class Public::OrdersController < ApplicationController
before_action :authenticate_customer!
    def new
    @order=Order.new
    end

    def create
     cart_items = current_customer.cart_items
     @order = Order.new(order_params)

      if @order.save
      cart_items.each do |cart|
        order_item = OrderItem.new
        order_item.order_id = @order.id
        order_item.making_status = 0
        order_item.item_id = cart.item_id
        order_item.amount = cart.amount
        order_item.price = cart.item.price
        order_item.save
        end
        cart_items.destroy_all
        redirect_to orders_thanks_path
      else
        @order = Order.new(order_params)
        render :new
      end
    end

    def comfirm
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      if params[:order][:address_number] =="1"

        @order.name = current_customer.full_name
        @order.address = current_customer.address
        @order.postal_code= current_customer.postal_code
      elsif params[:order][:address_number] == "2"
        if Address.exists?(name: params[:order][:registered])
          @order.name = Address.find(params[:order][:registered]).name
          @order.address = Address.find(params[:order][:registered]).address
          @order.postal_code = Address.find(params[:order][:registered]).postal_code
        else
          render :new
        end
      elsif params[:order][:address_number] == "3"
        address = current_customer.addresses.new(address_params)
        if address.save
        else
        render :new
        end
      end

      @cart_items = current_customer.cart_items.all
      # @total = @cart_items.inject(0) { |sum, item| sum + item.sum_price  }
    end

    def index

      @orders=current_customer.orders.all
      @order_item=OrderItem.new
    end


    def show
      @order=Order.find(params[:id])
      @order_item=OrderItem.new
      @order_items=@order.order_items

    end

    private

    def order_params
      params.require(:order).permit(:name, :payment_method, :address, :shipping_cost, :postal_code, :total_payment, :customer_id, :payment_method)
    end



    def address_params
      params.require(:order).permit(:name, :address, :postal_code)
    end
end

