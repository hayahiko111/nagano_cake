class Public::AddressesController < ApplicationController
  def index
    @adress=Address.new
    @addresses=Address.all
  end

  def create
    @address=Address.new(address_params)
    if @address.save
      redirect_to addresses_path
    else
      render:index
    end
  end

  def edit
  end

  private

  def address_params
    params.require(:address).permit(:customer_id, :name, :postal_code, :address)
  end
end
