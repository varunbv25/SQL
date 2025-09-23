CREATE DATABASE ECommerce;
USE ECommerce;

-- ECommerceDB Table Definitions
CREATE TABLE Ref_Address_Types (
    address_type_code VARCHAR(10) PRIMARY KEY,
    address_type_description VARCHAR(100) NOT NULL,
    billing_locations BOOLEAN DEFAULT FALSE,
    delivery_office BOOLEAN DEFAULT FALSE
);

CREATE TABLE Suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(255) NOT NULL,
    other_supplier_details TEXT
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_type_code VARCHAR(20) NOT NULL,
    supplier_id INT NOT NULL,
    product_price DECIMAL(10,2) NOT NULL,
    other_product_details TEXT,
    FOREIGN KEY (supplier_id) REFERENCES Suppliers(supplier_id) ON DELETE CASCADE
);

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL,
    customer_email VARCHAR(255) UNIQUE NOT NULL,
    other_customer_details TEXT
);

CREATE TABLE Addresses (
    address_id INT PRIMARY KEY,
    address_line_1_building VARCHAR(255) NOT NULL,
    line_2_number_street VARCHAR(255),
    line_3_area_locality VARCHAR(255),
    city VARCHAR(100) NOT NULL,
    zip_postcode VARCHAR(20) NOT NULL,
    state_province_country VARCHAR(100) NOT NULL,
    iso_country_code VARCHAR(3) NOT NULL,
    other_address_details TEXT
);

-- Sample Data Insertion
INSERT INTO Ref_Address_Types (address_type_code, address_type_description, billing_locations, delivery_office) VALUES
('BILLING', 'Billing Address', TRUE, FALSE),
('SHIPPING', 'Shipping Address', FALSE, TRUE),
('HOME', 'Home Address', TRUE, TRUE),
('OFFICE', 'Office Address', TRUE, TRUE);

INSERT INTO Suppliers (supplier_id, supplier_name, other_supplier_details) VALUES
(1, 'TechCorp Electronics', 'Leading supplier of consumer electronics'),
(2, 'Global Fashion Ltd', 'International clothing and accessories distributor'),
(3, 'BookWorld Publishing', 'Academic and fiction book publisher'),
(4, 'HomeComfort Inc', 'Furniture and home decoration specialist');

INSERT INTO Customers (customer_id, customer_name, customer_email, other_customer_details) VALUES
(1, 'John Smith', 'john.smith@email.com', 'Premium customer since 2020'),
(2, 'Sarah Johnson', 'sarah.j@gmail.com', 'Frequent buyer, prefers express shipping'),
(3, 'Michael Brown', 'mbrown@company.com', 'Corporate account holder'),
(4, 'Emma Wilson', 'emma.wilson@outlook.com', 'Student discount eligible');

INSERT INTO Addresses (address_id, address_line_1_building, line_2_number_street, line_3_area_locality, city, zip_postcode, state_province_country, iso_country_code, other_address_details) VALUES
(1, '123 Main Building', '456 Oak Street', 'Downtown', 'New York', '10001', 'New York', 'USA', 'Apartment 5B'),
(2, '789 Corporate Plaza', '321 Business Ave', 'Financial District', 'Chicago', '60601', 'Illinois', 'USA', 'Suite 1200'),
(3, '456 Residential Court', '789 Elm Road', 'Suburbia', 'Los Angeles', '90210', 'California', 'USA', 'Single family home'),
(4, '321 University Dorms', '654 College Street', 'Campus Area', 'Boston', '02101', 'Massachusetts', 'USA', 'Room 301');

INSERT INTO Products (product_id, product_type_code, supplier_id, product_price, other_product_details) VALUES
(1, 'ELECTRONICS', 1, 299.99, 'Wireless Bluetooth Headphones - Premium Quality'),
(2, 'CLOTHING', 2, 79.95, 'Cotton T-Shirt - Multiple Colors Available'),
(3, 'BOOKS', 3, 24.99, 'Programming Fundamentals Textbook - 5th Edition'),
(4, 'FURNITURE', 4, 449.00, 'Ergonomic Office Chair - Adjustable Height');

-- Display the contents of each table
SELECT * FROM Ref_Address_Types;
SELECT * FROM Suppliers;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Addresses;