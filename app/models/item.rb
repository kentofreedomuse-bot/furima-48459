class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category, optional: true
  belongs_to :status, optional: true
  belongs_to :shipping_fee, optional: true
  belongs_to :region, optional: true
  belongs_to :required_days, optional: true
  validates :name, presence: true
  validates :explanation, presence: true
  validates :category_id, presence: true, numericality: { other_than: 0 }
  validates :status_id, presence: true, numericality: { other_than: 0 }
  validates :shipping_fee_id, presence: true, numericality: { other_than: 0 }
  validates :region_id, presence: true, numericality: { other_than: 0 }
  validates :required_day_id, presence: true, numericality: { other_than: 0 }
  validates :price, presence: true,
                    numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 99_999_999 }
  has_one_attached :image
  validates :image, presence: true
end
