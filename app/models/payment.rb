class Payment < ApplicationRecord
  belongs_to :order
  validates :postcode, presence: true
  validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフンを含む正しい形式で入力してください' },
                       allow_blank: true
  validates :region_id, presence: true, numericality: { other_than: 0 }
  validates :city, presence: true
  validates :block, presence: true
  validates :phone_number, presence: true, format: { with: /\A\d{10,11}\z/, message: 'は10桁または11桁の数字で入力してください' }
end
