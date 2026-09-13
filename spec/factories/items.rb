FactoryBot.define do
  factory :item do
    association :user
    name { Faker::Commerce.product_name }
    explanation { Faker::Lorem.sentence }
    category_id { rand(1..10) }
    status_id { rand(1..6) }
    shipping_fee_id { rand(1..2) }
    region_id { rand(1..47) }
    required_day_id { rand(1..3) }
    price { rand(300..9_999_999) }

    after(:build) do |item|
      item.image.attach(
        io: StringIO.new('test image'),
        filename: 'test.jpg',
        content_type: 'image/jpeg'
      )
    end
  end
end
