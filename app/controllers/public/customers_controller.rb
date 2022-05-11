class Public::CustomersController < ApplicationController
  def show
    @customer=current_customer
  end

  def edit
    @customer=current_customer
  end

  def update
    @customer=current_customer(params)
    if @customer.update(customer_params)
      flash[:notice] = "You have created genre successfully."
      redirect_to customers_path
    else
      render:edit
    end
  end

  def confirm
    @customer=current_customer
  end

  def withdraw
    @customer=current_customer(params)
    @customer.update(is_deleted)
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
  end

  def is_deleted
    params.require(:customer).permit(:is_deleted)
  end
end