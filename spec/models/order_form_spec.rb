require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  let(:user) { create(:user) }
  let(:item) { create(:item, user: user) }

  before do
    Payment.delete_all
    Order.delete_all
    @order_form = FactoryBot.build(:order_form, user: user, item: item)
  end

  describe '購入処理' do
    context '購入がうまくいくとき' do
      it '全ての値が正しく入力されていれば購入できる' do
        expect(@order_form).to be_valid
        expect(@order_form.save).to be true
        expect(Order.count).to eq(1)
      end

      it 'buildingが空でも購入できる' do
        @order_form.building = nil
        expect(@order_form).to be_valid
        expect(@order_form.save).to be true
        expect(Order.count).to eq(1)
      end
    end

    context '購入がうまくいかないとき' do
      it 'user_idが空では購入できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では購入できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では購入できない' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end

      it 'postcodeが空では購入できない' do
        @order_form.postcode = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postcode 郵便番号を入力してください')
      end

      it 'postcodeにハイフンが含まれていない場合は購入できない' do
        @order_form.postcode = '1234567'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Postcode 郵便番号はハイフンを含む正しい形式で入力してください')
      end

      it 'region_idが0の場合は購入できない' do
        @order_form.region_id = 0
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Region 都道府県を選択してください')
      end

      it 'cityが空では購入できない' do
        @order_form.city = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('City 市区町村を入力してください')
      end

      it 'blockが空では購入できない' do
        @order_form.block = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Block 番地を入力してください')
      end

      it 'phone_numberが空では購入できない' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number 電話番号を入力してください')
      end

      it 'phone_numberにハイフンが含まれている場合は購入できない' do
        @order_form.phone_number = '090-1234-5678'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number 電話番号は10桁または11桁の数字で入力してください')
      end
    end
  end
end
