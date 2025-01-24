class OrderForm
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :city, :address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含めて入力してください' }
    validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
    validates :city
    validates :address
    validates :phone_number, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁で入力してください' }
    validates :token
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(
      postal_code: postal_code, prefecture_id: prefecture_id, city: city, address: address,
      building: building, phone_number: phone_number, order_id: order.id
    )
  end
end
