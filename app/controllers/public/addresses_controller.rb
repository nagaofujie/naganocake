class Public::AddressesController < ApplicationController

def index
  @address=Address.new
  @addresses=Address.all
end

def create
  @address=current_customer.addresses.new(address_params)
  @addresses=Address.all
  @address.save
  redirect_to addresses_path
end

def edit
  @address = Address.find(params[:id])
end

def update
  @address=Address.find(params[:id])
  if @address.update(address_params)
  redirect_to addresses_path
  else
  render :edit
  end
end

def destroy
  @address=Address.find(params[:id])
  @address.destroy
  redirect_to addresses_path
end

private

def address_params
   params.require(:address).permit(:postal_code, :address, :name)
end


end
