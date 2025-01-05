class Item < ApplicationRecord
  # ActiveHashのアソシエーション拡張
  extend ActiveHash::Associations::ActiveRecordExtensions

  # アソシエーション
  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :prefecture
  belongs_to :shipping_day

  has_one_attached :image # ActiveStorage用の設定
  has_one :purchase

  # バリデーション
  # 必須項目
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 }

  # ActiveHashを使用した項目のバリデーション
  validates :category_id, :condition_id, :shipping_fee_id, :prefecture_id, :shipping_day_id,
            numericality: { other_than: 1, message: "can't be blank" }

  # 画像のバリデーション
  validates :image, presence: true

  # インスタンスメソッド
  def sold_out?
    purchase.present?
  end
end
