require 'rails_helper'

RSpec.describe Purchase, type: :model do
  before do
    @purchase = FactoryBot.build(:purchase)
  end

  describe '購入情報の保存' do
    context '購入情報が保存できる場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase).to be_valid
      end
    end

    context '購入情報が保存できない場合' do
      it 'userが紐付いていないと保存できないこと' do
        @purchase.user = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('User must exist')
      end

      it 'itemが紐付いていないと保存できないこと' do
        @purchase.item = nil
        @purchase.valid?
        expect(@purchase.errors.full_messages).to include('Item must exist')
      end
    end
  end
end
