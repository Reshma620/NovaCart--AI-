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
