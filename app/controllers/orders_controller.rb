class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
  end

  def create
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new(order_params)
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    if @order_form.valid?
      begin
        pay_item
        @order_form.save
        redirect_to root_path
      rescue Payjp::PayjpError => e
        Rails.logger.error("PAY.JPエラー: #{e.message}")
        flash.now[:alert] = "クレジットカード決済に失敗しました: #{e.message}"
        render :index
      end
    else
      Rails.logger.info "バリデーションエラー: #{@order_form.errors.full_messages}"
      render :index
    end
  end

  private

  def order_params
    params.require(:order_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token, :price).merge(
      user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: order_params[:price], # 商品価格を決済金額として設定
      card: order_params[:token],   # カードトークン
      currency: 'jpy' # 日本円
    )
  end
end
