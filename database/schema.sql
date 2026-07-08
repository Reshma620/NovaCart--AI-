-- ============================================
-- NovaCart AI Database Schema
-- Version : 1.0
-- Author  : Reshma Kumari
-- ============================================

CREATE DATABASE IF NOT EXISTS NovaCart_AI;

USE NovaCart_AI;

-- ============================================
-- Table: customers
-- Description: Stores customer information
-- ============================================

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    gender ENUM('Male','Female','Other'),
    date_of_birth DATE,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50) DEFAULT 'India',
    registration_date DATE NOT NULL,
    customer_segment ENUM('Regular','Silver','Gold','Platinum') DEFAULT 'Regular',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================
-- Table: categories
-- Description: Stores product categories
-- ============================================

CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);

-- ============================================
-- Table: suppliers
-- Description: Stores supplier information
-- ============================================

CREATE TABLE suppliers (
    supplier_id INT AUTO_INCREMENT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_person VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    rating DECIMAL(2,1)
);

-- ============================================
-- Table: products
-- Description: Stores product information
-- ============================================

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,

    category_id INT NOT NULL,

    supplier_id INT NOT NULL,

    product_name VARCHAR(150) NOT NULL,

    brand VARCHAR(100),

    description TEXT,

    cost_price DECIMAL(10,2) NOT NULL,

    selling_price DECIMAL(10,2) NOT NULL,

    stock_unit VARCHAR(20) DEFAULT 'Piece',

    status ENUM('Active','Inactive') DEFAULT 'Active',

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_product_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id),

    CONSTRAINT fk_product_supplier
        FOREIGN KEY (supplier_id)
        REFERENCES suppliers(supplier_id)
);

-- ============================================
-- Table: coupons
-- Description: Stores coupon information
-- ============================================

CREATE TABLE coupons (
    coupon_id INT AUTO_INCREMENT PRIMARY KEY,

    coupon_code VARCHAR(30) UNIQUE NOT NULL,

    discount_type ENUM('Percentage','Flat') NOT NULL,

    discount_value DECIMAL(10,2) NOT NULL,

    minimum_order_amount DECIMAL(10,2),

    start_date DATE,

    end_date DATE,

    status ENUM('Active','Expired') DEFAULT 'Active'
);

-- ============================================
-- Table: orders
-- Description: Stores customer orders
-- ============================================

CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,

    customer_id INT NOT NULL,

    coupon_id INT,

    order_date DATETIME NOT NULL,

    order_status ENUM(
        'Pending',
        'Confirmed',
        'Packed',
        'Shipped',
        'Delivered',
        'Cancelled',
        'Returned'
    ) DEFAULT 'Pending',

    total_amount DECIMAL(10,2) NOT NULL,

    shipping_charge DECIMAL(10,2) DEFAULT 0,

    tax_amount DECIMAL(10,2) DEFAULT 0,

    final_amount DECIMAL(10,2) NOT NULL,

    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_order_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    CONSTRAINT fk_order_coupon
        FOREIGN KEY (coupon_id)
        REFERENCES coupons(coupon_id)
);

-- ============================================
-- Table: order_items
-- Description: Stores products included in each order
-- ============================================

CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id INT NOT NULL,

    product_id INT NOT NULL,

    quantity INT NOT NULL,

    unit_price DECIMAL(10,2) NOT NULL,

    discount DECIMAL(10,2) DEFAULT 0,

    profit DECIMAL(10,2),

    subtotal DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_orderitem_order
        FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_orderitem_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
    );

-- ============================================
-- Table: payments
-- Description: Stores payment details
-- ============================================

CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id INT NOT NULL,

    payment_method ENUM(
        'Credit Card',
        'Debit Card',
        'UPI',
        'Net Banking',
        'Wallet',
        'Cash on Delivery'
    ) NOT NULL,

    payment_status ENUM(
        'Pending',
        'Completed',
        'Failed',
        'Refunded'
    ) DEFAULT 'Pending',

    transaction_id VARCHAR(100) UNIQUE,

    payment_date DATETIME,

    amount_paid DECIMAL(10,2) NOT NULL,

    CONSTRAINT fk_payment_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id)
);

-- ============================================
-- Table: shipping_partners
-- ============================================

CREATE TABLE shipping_partners (
    partner_id INT AUTO_INCREMENT PRIMARY KEY,

    partner_name VARCHAR(100) NOT NULL,

    contact_number VARCHAR(15),

    email VARCHAR(100),

    service_type VARCHAR(50),

    rating DECIMAL(2,1)
);

-- ============================================
-- Table: warehouses
-- ============================================

CREATE TABLE warehouses (

    warehouse_id INT AUTO_INCREMENT PRIMARY KEY,

    warehouse_name VARCHAR(100) NOT NULL,

    city VARCHAR(50),

    state VARCHAR(50),

    capacity INT,

    manager_name VARCHAR(100)
);

-- ============================================
-- Table: inventory
-- ============================================

CREATE TABLE inventory (

    inventory_id INT AUTO_INCREMENT PRIMARY KEY,

    warehouse_id INT NOT NULL,

    product_id INT NOT NULL,

    stock_quantity INT NOT NULL,

    reorder_level INT NOT NULL,

    last_updated DATETIME,

    CONSTRAINT fk_inventory_warehouse
        FOREIGN KEY (warehouse_id)
        REFERENCES warehouses(warehouse_id),

    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- ============================================
-- Table: shipments
-- ============================================

CREATE TABLE shipments (

    shipment_id INT AUTO_INCREMENT PRIMARY KEY,

    order_id INT NOT NULL,

    warehouse_id INT NOT NULL,

    partner_id INT NOT NULL,

    ship_date DATE,

    expected_delivery DATE,

    actual_delivery DATE,

    shipping_cost DECIMAL(10,2),

    delivery_status ENUM(
        'Pending',
        'Shipped',
        'In Transit',
        'Delivered',
        'Delayed'
    ) DEFAULT 'Pending',

    CONSTRAINT fk_shipment_order
        FOREIGN KEY(order_id)
        REFERENCES orders(order_id),

    CONSTRAINT fk_shipment_warehouse
        FOREIGN KEY(warehouse_id)
        REFERENCES warehouses(warehouse_id),

    CONSTRAINT fk_shipment_partner
        FOREIGN KEY(partner_id)
        REFERENCES shipping_partners(partner_id)
);




    

