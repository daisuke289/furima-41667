class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(order_form_params)
    if @order_form.valid?
      pay_item # クレジットカード決済処理
      @order_form.save
      redirect_to root_path
    else
      render :index
    end
  end
end

private

def order_form_params
  params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building, :phone_number, :token).merge(
    user_id: current_user.id, item_id: params[:item_id]
  )
end

def pay_item
  Payjp.api_key = ENV['PAYJP_SECRET_KEY']
  Payjp::Charge.create(
    amount: @item.price,
    card: order_form_params[:token],
    currency: 'jpy'
  )
end
