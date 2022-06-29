# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

before_action :reject_inactive_customer, only: [:create]
before_action :authenticate_customer!, except: [:about, :index, :top]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end
  private

  def after_sign_in_path_for(resource)
    homes_top_path
  end

  def after_sign_out_path_for(resource)
    homes_top_path
  end

   protected

def reject_inactive_customer
    @customer=Customer.find_by(email: params[:customer][:name])
    if @customer
      if @customer.valid_password?(params[:user][:password]) && !@customer.is_deleted
        redirect_to new_customer_session_path
      end
    end
  end


  def configure_permited_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number])
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

