FactoryBot.define do
  factory :order_form do
    user_id { nil }
    item_id { nil }
    token { 'tok_abcdefghijk00000000000000000' }
    postcode { '123-4567' }
    region_id { 27 }
    city { '大阪市' }
    block { '北区1-1-1' }
    building { 'テストビル' }
    phone_number { '09012345678' }

    transient do
      user { nil }
      item { nil }
    end

    after(:build) do |order_form, evaluator|
      order_form.user_id = evaluator.user&.id || order_form.user_id
      order_form.item_id = evaluator.item&.id || order_form.item_id
    end
  end
end
