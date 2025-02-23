class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :prevent_self_purchase
  before_action :prevent_sold_item

  def index
    @order_form = OrderForm.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @order_form = OrderForm.new(order_params)
    if @order_form.valid?
      pay_item
      @order_form.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index, status: :unprocessable_entity
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def prevent_sold_item
    return unless @item.purchase.present?

    redirect_to root_path
  end

  def prevent_self_purchase
    return unless current_user.id == @item.user_id

    redirect_to root_path
  end

  def order_params
    params.require(:order_form)
          .permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number)
          .merge(
            user_id: current_user.id,
            item_id: params[:item_id],
            token: params[:order_form][:token]
          )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
