# Furima-41667 Database Design

## Database Schema
以下は、各テーブルの構造とアソシエーションを記載したものです。

---

### Users Table
| Column             | Type       | Options                  |
|--------------------|------------|--------------------------|
| nickname           | string     | null: false             |
| email              | string     | null: false, unique: true |
| encrypted_password | string     | null: false             |
| last_name          | string     | null: false             |
| first_name         | string     | null: false             |
| last_name_kana     | string     | null: false             |
| first_name_kana    | string     | null: false             |
| birthday           | date       | null: false             |

#### **Associations**
- has_many :items
- has_many :purchases

---

### Items Table
| Column             | Type       | Options                   |
|--------------------|------------|---------------------------|
| name               | string     | null: false              |
| description        | text       | null: false              |
| category           | integer    | null: false              |
| condition          | integer    | null: false              |
| shipping_fee       | integer    | null: false              |
| prefecture         | integer    | null: false              |
| shipping_day       | integer    | null: false              |
| price              | integer    | null: false              |
| user               | references | null: false, foreign_key: true |

#### **Associations**
- belongs_to :user
- has_one :purchase

---

### Purchases Table
| Column   | Type       | Options                   |
|----------|------------|---------------------------|
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

#### **Associations**
- belongs_to :user
- belongs_to :item
- has_one :shipping_address

---

### ShippingAddresses Table
| Column         | Type       | Options                   |
|----------------|------------|---------------------------|
| purchase       | references | null: false, foreign_key: true |
| postal_code    | string     | null: false              |
| prefecture     | integer    | null: false              |
| city           | string     | null: false              |
| address        | string     | null: false              |
| building_name  | string     |                          |
| phone_number   | string     | null: false              |

#### **Associations**
- belongs_to :purchase