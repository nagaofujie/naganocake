class Public::HomesController < ApplicationController
  before_action :authenticate_customer!,except: [:top,:about]

  def top
   @items=Item.all.page(params[:page]).per(4)
  end

  def about
  end



end
