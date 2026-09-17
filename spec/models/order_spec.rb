require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  context '商品購入がうまくいくとき' do
    it 'tokenがあれば購入できる' do
      expect(@order).to be_valid
    end
  end

  context '商品購入がうまくいかないとき' do
    it 'tokenが空では購入できない' do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
  end
end
