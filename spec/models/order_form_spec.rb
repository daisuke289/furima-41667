require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_form = OrderForm.new(
      postal_code: '123-4567', prefecture_id: 2, city: '横浜市', address: '青山1-1-1',
      building: '青山ビル', phone_number: '09012345678', user_id: @user.id, item_id: @item.id, token: 'tok_abcdefghijk00000000000000000'
    )
  end

  it '全ての情報が正しく入力されていれば保存できる' do
    expect(@order_form).to be_valid
  end

  it 'postal_codeが空では保存できない' do
    @order_form.postal_code = ''
    expect(@order_form).to_not be_valid
  end

  # 他のテストケースも追加
end
