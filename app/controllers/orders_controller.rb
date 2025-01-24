class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @order_form = OrderForm.new
  end

  def create
    # 購入処理を実装予定
  end
end
