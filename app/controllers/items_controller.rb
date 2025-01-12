class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    # @items = Item.includes(image_attachment: :blob).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params.merge(user: current_user))
    if @item.save
      redirect_to root_path
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
