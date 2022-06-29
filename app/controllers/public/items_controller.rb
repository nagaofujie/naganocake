class Public::ItemsController < ApplicationController
 before_action :authenticate_customer!, except: [:index]


def create
  @item =Item.new
  if @item.save
    redirect_to cart_items_path
  else
    render :show
  end
end


def index
  @item=Item.new
  @items=Item.page(params[:page]).per(8)
end

def show
  @item=Item.find(params[:id])
  @cart_item = CartItem.new

end

private

def item_params
params.require(:item).permit(:name, :introduction, :price, :image, :tax_in, :amount)
end

end
