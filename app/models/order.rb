class Order
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含めて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' } # ← 変更の可能性
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A0\d{9,10}\z/, message: 'は10桁または11桁の半角数字で入力してください' }
    validates :token # ← クレジット決済を考慮し、トークン必須
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)

    if purchase.persisted? # Purchaseが保存されたか確認
      ShippingAddress.create(
        postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
        building_name: building_name, phone_number: phone_number, purchase_id: purchase.id
      )
    else
      false # Purchaseが保存されなかった場合は false を返す
    end
  end
end
