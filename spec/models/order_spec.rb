require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '注文がうまくいくとき' do
    it 'ユーザーと商品が紐づいていれば有効になる' do
      expect(@order).to be_valid
    end
  end
end
