class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status, optional: true
  belongs_to :shipping_fee, optional: true
  belongs_to :region, optional: true
  belongs_to :required_days, optional: true
  validates :name, presence: true
  validates :explanation, presence: true
end
