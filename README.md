# README

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| nickname           | string | null: false |

### Association

- has_many :items
- has_many :comments
- has_one :profile




## items テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| name               | string      | null: false |
| explanation        | text        | null: false |
| caregory           | string      | null: false |
| status             | string      | null: false |
| shipping_fee       | string      | null: false |
| region             | string      | null: false |
| days               | string      | null: false |
| price              | string      | null: false |
| user_id            | references  | null: false , foreign_key: true|

### Association

- belongs_to :user
- has_many :comments
- has_one :order



## comments テーブル

| Column             | Type       | Options     |
| ------------------ | ---------- | ----------- |
| content            | text       | null: false |
| item_id            | references | null: false , foreign_key: true|
| user_id            | references | null: false , foreign_key: true|

### Association

- belongs_to :user
- belongs_to :item



## profiles テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| last_name          | string      | null: false |
| first_name         | string      | null: false |
| birth_year         | string      | null: false |
| birth_month        | string      | null: false |
| birth_day          | string      | null: false |
| user_id            | references  | null: false , foreign_key: true|

### Association

- belongs_to :user



## orders テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| postcode           | string      | null: false |
| prefecture         | string      | null: false |
| city               | string      | null: false |
| block              | string      | null: false |
| building           | string      |
| phone_number       | string      | null: false |
| user_id            | references  | null: false , foreign_key: true|
| items_id           | references  | null: false , foreign_key: true|

### Association

- belongs_to :item