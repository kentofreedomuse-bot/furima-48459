require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  let(:user) do
    User.create!(email: 'order_form@example.com', password: 'Password1', password_confirmation: 'Password1', nickname: '購入者',
                 last_name: '山田', first_name: '太郎', last_name_kana: 'ヤマダ', first_name_kana: 'タロウ', birthday: '1990-01-01')
  end
  let(:item) do
    item = Item.new(
      user: user,
      name: 'フォーム商品',
      explanation: '説明',
      category_id: 1,
      status_id: 1,
      shipping_fee_id: 1,
      region_id: 1,
      required_day_id: 1,
      price: 2000
    )
    item.image.attach(io: StringIO.new('test image'), filename: 'test.jpg', content_type: 'image/jpeg')
    item.save!
    item
  end

  describe '#save' do
    it '正常な購入情報を保存できる' do
      form = described_class.new(
        user_id: user.id,
        item_id: item.id,
        postcode: '123-4567',
        region_id: 27,
        city: '大阪市',
        block: '北区1-1-1',
        building: 'テストビル',
        phone_number: '09012345678'
      )

      expect(form.save).to be true
      expect(Order.count).to eq(1)
      expect(Payment.count).to eq(1)
    end

    it '不正な値では保存できない' do
      form = described_class.new(
        user_id: user.id,
        item_id: item.id,
        postcode: '1234',
        region_id: 0,
        city: '',
        block: '',
        phone_number: '123'
      )

      expect(form.save).to be false
      expect(form.errors.full_messages).to include('Postcode 郵便番号はハイフンを含む正しい形式で入力してください')
      expect(Order.count).to eq(0)
    end
  end
end
