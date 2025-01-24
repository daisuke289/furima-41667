class OrdersController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    # 購入機能に必要な他の処理はここに記載します
  end

  def create
    # 購入処理を実装予定
  end
end
