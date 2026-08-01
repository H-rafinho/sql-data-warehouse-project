/*
=============================================
DDL Script: Create Bronze Tables
=============================================
Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables
*/



IF OBJECT_ID('bronze.mock_data_categories', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_categories;
CREATE TABLE bronze.mock_data_categories(
    category_id INT,
    category_name VARCHAR(20),
    description VARCHAR(50)
)
GO

IF OBJECT_ID('bronze.mock_data_customers', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_customers;
CREATE TABLE bronze.mock_data_customers(
    customer_id INT,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    email VARCHAR(50),
    country VARCHAR(20),
    phone VARCHAR(15),
    signup_date VARCHAR(20)
)
GO

IF OBJECT_ID('bronze.mock_data_employees', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_employees;
CREATE TABLE bronze.mock_data_employees(
    employee_id INT,
    first_name VARCHAR(15),
    last_name VARCHAR(15),
    title VARCHAR(20),
    hir_date VARCHAR(20)
)
GO

IF OBJECT_ID('bronze.mock_data_order_items', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_order_items;
CREATE TABLE bronze.mock_data_order_items(
    order_item_id INT,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10,2),
    discount DECIMAL(10,2)
)
GO

IF OBJECT_ID('bronze.mock_data_orders', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_orders;
CREATE TABLE bronze.mock_data_orders(
    order_id INT,
    customer_id INT,
    employee_id INT,
    order_date VARCHAR(15),
    ship_country VARCHAR(20)
)
GO

IF OBJECT_ID('bronze.mock_data_products', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_products;
CREATE TABLE bronze.mock_data_products(
    product_id INT,
    product_name VARCHAR(30),
    category_id INT,
    supplier_id INT,
    unit_price VARCHAR(20),
    units_in_stock INT,
    discontinued VARCHAR(10)
)
GO

IF OBJECT_ID('bronze.mock_data_suppliers', 'U') IS NOT NULL
    DROP TABLE bronze.mock_data_suppliers;
CREATE TABLE bronze.mock_data_suppliers(
    supplier_id INT,
    company_name VARCHAR(20),
    contact_name VARCHAR(20),
    country VARCHAR(20),
    phone VARCHAR(20),
    email VARCHAR(30)
)
GO



