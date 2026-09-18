class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  has_one :order
  belongs_to :category
  belongs_to :status
  belongs_to :shipping_fee
  belongs_to :region
  belongs_to :required_day, class_name: 'RequiredDays', foreign_key: :required_day_id
  validates :name, presence: true
  validates :explanation, presence: true
  validates :category_id, presence: true, numericality: { other_than: 0 }
  validates :status_id, presence: true, numericality: { other_than: 0 }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 0 }
  validates :region_id, presence: true, numericality: { other_than: 0 }
  validates :required_day_id, presence: true, numericality: { other_than: 0 }
  validates :price, presence: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999 },
                    allow_blank: true
  has_one_attached :image
  validates :image, presence: true
end
