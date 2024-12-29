# Furima-41667 Database Design

## Database Schema
以下は、各テーブルの構造とリレーションを記載したものです。

### Users Table
| Column             | Type   | Options                  |
|--------------------|--------|--------------------------|
| id                 | bigint | Primary Key             |
| nickname           | string | null: false             |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false             |
| last_name          | string | null: false             |
| first_name         | string | null: false             |
| last_name_kana     | string | null: false             |
| first_name_kana    | string | null: false             |
| birthday           | date   | null: false             |

### Items Table
| Column             | Type    | Options                   |
|--------------------|---------|---------------------------|
| id                 | bigint  | Primary Key              |
| name               | string  | null: false              |
| description        | text    | null: false              |
| category_id        | integer | null: false              |
| condition_id       | integer | null: false              |
| shipping_fee_id    | integer | null: false              |
| prefecture_id      | integer | null: false              |
| shipping_days_id   | integer | null: false              |
| price              | integer | null: false              |
| user_id            | bigint  | null: false, foreign_key |

### Purchases Table
| Column   | Type    | Options                   |
|----------|---------|---------------------------|
| id       | bigint  | Primary Key              |
| user_id  | bigint  | null: false, foreign_key |
| item_id  | bigint  | null: false, foreign_key |

### ShippingAddresses Table
| Column         | Type    | Options                   |
|----------------|---------|---------------------------|
| id             | bigint  | Primary Key              |
| purchase_id    | bigint  | null: false, foreign_key |
| postal_code    | string  | null: false              |
| prefecture_id  | integer | null: false              |
| city           | string  | null: false              |
| address        | string  | null: false              |
| building_name  | string  |                          |
| phone_number   | string  | null: false              |

## Relations
- `users` has_many `items`
- `users` has_many `purchases`
- `items` belongs_to `users`
- `items` has_one `purchase`
- `purchases` belongs_to `users`
- `purchases` belongs_to `items`
- `purchases` has_one `shipping_address`
- `shipping_addresses` belongs_to `purchase`