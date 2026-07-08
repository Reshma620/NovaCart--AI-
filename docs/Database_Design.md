# Database Design

## Database Name

NovaCart_AI

---

## Database Type

Relational Database Management System (RDBMS)

---

## Database Engine

MySQL 8.0

---

## Design Approach

The database is designed using normalization principles (up to Third Normal Form - 3NF) to reduce redundancy and maintain data integrity.

---

## Core Business Modules

- Customer Management
- Product Management
- Sales Management
- Inventory Management
- Shipping Management
- Returns Management
- Marketing Analytics
- AI Analytics

---

## Total Tables

18

| Table Name | Module |
|------------|--------|
| customers | Customer |
| categories | Product |
| suppliers | Product |
| products | Product |
| orders | Sales |
| order_items | Sales |
| payments | Sales |
| warehouses | Inventory |
| inventory | Inventory |
| shipments | Shipping |
| shipping_partners | Shipping |
| returns | Returns |
| reviews | Customer |
| campaigns | Marketing |
| coupons | Marketing |
| employees | HR |
| customer_support_tickets | Customer Support |
| product_views | Customer Analytics |

---

## Normalization

The database follows:

- First Normal Form (1NF)
- Second Normal Form (2NF)
- Third Normal Form (3NF)

to eliminate duplicate data and improve consistency.

---

## Primary Keys

Every table contains a unique Primary Key.

Example:

- customer_id
- order_id
- product_id
- supplier_id

---

## Foreign Keys

Relationships between tables are maintained using Foreign Keys.

Example:

orders.customer_id → customers.customer_id

products.category_id → categories.category_id

products.supplier_id → suppliers.supplier_id

order_items.order_id → orders.order_id

order_items.product_id → products.product_id
