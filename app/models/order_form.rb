class OrderForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attr_accessor :user_id, :item_id, :postcode, :region_id, :city, :block, :building, :phone_number

  validates :user_id, presence: true
  validates :item_id, presence: true
  validates :postcode, presence: { message: '郵便番号を入力してください' }
  validates :postcode, format: { with: /\A\d{3}-\d{4}\z/, message: '郵便番号はハイフンを含む正しい形式で入力してください' }, allow_blank: true
  validates :region_id, presence: { message: '都道府県を選択してください' }, numericality: { other_than: 0, message: '都道府県を選択してください' }
  validates :city, presence: { message: '市区町村を入力してください' }
  validates :block, presence: { message: '番地を入力してください' }
  validates :phone_number, presence: { message: '電話番号を入力してください' }
  validates :phone_number, format: { with: /\A\d{10,11}\z/, message: '電話番号は10桁または11桁の数字で入力してください' }, allow_blank: true

  def save
    return false unless valid?

    order = Order.create!(user_id: user_id, item_id: item_id)
    Payment.create!(
      order_id: order.id,
      postcode: postcode,
      region_id: region_id,
      city: city,
      block: block,
      building: building,
      phone_number: phone_number
    )
    true
  rescue ActiveRecord::RecordInvalid
    false
  end
end
