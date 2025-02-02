class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order = Order.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = Order.new(order_params)
    if @order.valid?
      begin
        pay_item # クレジットカード決済処理
        @order.save
        redirect_to root_path
      rescue Payjp::PayjpError => e
        Rails.logger.error("PAY.JPエラー: #{e.message}")
        flash.now[:alert] = "クレジットカード決済に失敗しました: #{e.message}"
        render :index
      end
    else
      Rails.logger.info "バリデーションエラー: #{@order.errors.full_messages}"
      render :index
    end
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token).merge(
      user_id: current_user.id, item_id: params[:item_id]
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
