FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { "A#{Faker::Number.number(digits: 8)}" }
    password_confirmation { password }
    nickname { Faker::Internet.username }
    last_name { %w[鈴木 佐藤 高橋 田中].sample }
    first_name { %w[健人 太郎 花子].sample }
    last_name_kana { %w[スズキ サトウ タカハシ タナカ].sample }
    first_name_kana { %w[ケント タロウ ハナコ].sample }
    birthday { Faker::Date.birthday(min_age: 5, max_age: 100) }
  end
end
