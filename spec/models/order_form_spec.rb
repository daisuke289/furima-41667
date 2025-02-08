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

  describe '購入情報の保存' do
    context '購入がうまくいくとき' do
      it 'すべての値が正しく入力されていれば保存できる' do
        expect(@order_form).to be_valid
      end

      it '建物名が空でも保存できる' do
        @order_form.building = ''
        expect(@order_form).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it '郵便番号が空では保存できない' do
        @order_form.postal_code = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal codeを入力してください')
      end

      it '郵便番号がハイフンを含まない形式では保存できない' do
        @order_form.postal_code = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postal codeはハイフンを含めて入力してください')
      end

      it '電話番号が空では保存できない' do
        @order_form.phone_number = ''
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone numberを入力してください')
      end

      it '電話番号が12桁以上では保存できない' do
        @order_form.phone_number = '090123456789'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone numberは10桁または11桁で入力してください')
      end

      # 他のエラーケースも追加可能
    end
  end
end
