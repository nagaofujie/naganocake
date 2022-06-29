class Public::CustomersController < ApplicationController
before_action :authenticate_customer!


  def mypage
  @customer = current_customer
  end

  def edit
  @customer=current_customer
  end

  def update
  @customer = current_customer
  @customer.update(customer_params)
  redirect_to mypage_path
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: false)
    reset_session
    redirect_to homes_top_path
  end



  private


  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :postal_code,:address,:telephone_number,:email,:full_name,:full_name_kana)
  end
end