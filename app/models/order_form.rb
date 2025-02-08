class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含めて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A0\d{9,10}\z/, message: 'は10桁または11桁の半角数字で入力してください' }
    validates :token
  end

  def save
    ActiveRecord::Base.transaction do
      purchase = Purchase.create!(user_id: user_id, item_id: item_id)
      ShippingAddress.create!(
        postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
        building_name: building_name, phone_number: phone_number, purchase_id: purchase.id
      )
    end
  rescue ActiveRecord::RecordInvalid
    false
  end
end
