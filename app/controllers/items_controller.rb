class ItemsController < ApplicationController
  def index
    # トップページ用の処理（必要に応じて）
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path, notice: '商品が出品されました。'
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :condition_id, :price, :shipping_fee_id, :prefecture_id,
                                 :shipping_day_id, :image)
  end
end
