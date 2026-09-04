# README

# テーブル設計

## users テーブル

| Column             | Type   | Options     |
| ------------------ | ------ | ----------- |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false |
| nickname           | string | null: false |
| last_name          | string | null: false |
| first_name         | string | null: false |
| birthday           | date   | null: false |

### Association

- has_many :items
- has_many :orders




## items テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| name               | string      | null: false |
| explanation        | text        | null: false |
| category           | integer     | null: false |
| status             | integer     | null: false |
| shipping_fee       | integer     | null: false |
| region             | integer     | null: false |
| days               | integer     | null: false |
| price              | string      | null: false |
| user               | references  | null: false , foreign_key: true|

### Association

- belongs_to :user
- has_one :payment
- has_one :order



## orders テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| user               | references  | null: false , foreign_key: true|
| items              | references  | null: false , foreign_key: true|

### Association

- belongs_to :item
- has_one :payment



## payments テーブル

| Column             | Type        | Options     |
| ------------------ | ----------- | ----------- |
| postcode           | string      | null: false |
| prefecture         | string      | null: false |
| city               | string      | null: false |
| block              | string      | null: false |
| building           | string      |
| phone_number       | string      | null: false |
| order              | references  | null: false , foreign_key: true|

### Association

- belongs_to :item
- belongs_to :order