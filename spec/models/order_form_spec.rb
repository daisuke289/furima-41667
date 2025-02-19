require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @order_form = OrderForm.new(
      postal_code: '123-4567',
      prefecture_id: 2,
      city: '横浜市',
      address: '青山1-1-1',
      building_name: '青山ビル',
      phone_number: '09012345678',
      user_id: 1,
      item_id: 1,
      token: 'tok_abcdefghijk00000000000000000'
    )
  end

  context '商品の購入ができる場合' do
    it '全ての項目が正しく入力されていれば保存できる' do
      expect(@order_form).to be_valid
    end

    it '建物名が空でも保存できる' do
      @order_form.building_name = ''
      expect(@order_form).to be_valid
    end
  end

  context '商品の購入ができない場合' do
    it '郵便番号が空では保存できない' do
      @order_form.postal_code = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
    end

    it '郵便番号がハイフンを含まない形式では保存できない' do
      @order_form.postal_code = '1234567'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Postal code はハイフンを含めて入力してください')
    end

    it '都道府県が未選択（1）では保存できない' do
      @order_form.prefecture_id = 1
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Prefecture を選択してください')
    end

    it '市区町村が空では保存できない' do
      @order_form.city = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("City can't be blank")
    end

    it '番地が空では保存できない' do
      @order_form.address = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Address can't be blank")
    end

    it '電話番号が空では保存できない' do
      @order_form.phone_number = ''
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
    end

    it '電話番号が9桁以下では保存できない' do
      @order_form.phone_number = '090123456'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number は10桁または11桁の半角数字で入力してください')
    end

    it '電話番号が12桁以上では保存できない' do
      @order_form.phone_number = '090123456789'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number は10桁または11桁の半角数字で入力してください')
    end

    it '電話番号にハイフンが含まれていると保存できない' do
      @order_form.phone_number = '090-1234-5678'
      @order_form.valid?
      expect(@order_form.errors.full_messages).to include('Phone number は10桁または11桁の半角数字で入力してください')
    end
  end
end
