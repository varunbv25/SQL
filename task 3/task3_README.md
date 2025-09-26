# Task 3 - SQL Query Practice

This directory contains SQL practice exercises working with an ecommerce database.

## Files

- `task_3.mysql-notebook` - MySQL notebook containing comprehensive SQL queries and exercises

## Database Schema

The exercises work with an **ecommerce** database containing the following tables:

- `Ref_Address_Types` - Reference table for address types
- `Suppliers` - Supplier information
- `Products` - Product catalog with pricing and categories
- `Customers` - Customer information and contact details
- `Addresses` - Address records linked to customers

## SQL Concepts Covered

### Basic Queries
- Simple SELECT statements
- Selecting specific columns
- Using WHERE clauses for filtering

### Advanced Filtering
- Comparison operators (`>`, `<`, `>=`, `<=`, `=`)
- Range filtering with `BETWEEN`
- Pattern matching with `LIKE`
- Multiple conditions with `AND`/`OR`
- Using `IN` operator for multiple values

### Sorting and Limiting
- `ORDER BY` for sorting (ascending and descending)
- `LIMIT` for restricting result sets
- Multiple column sorting

### Data Analysis
- `DISTINCT` for unique values
- `COUNT(*)` for record counts
- `UNION ALL` for combining results
- Complex conditional filtering

### Database Exploration
- `SHOW TABLES` for schema discovery
- Data exploration across multiple tables

## Key Query Examples

- Product filtering by price range and category
- Customer email domain analysis
- Top N products by price
- Complex multi-condition filtering
- Table record counting and statistics

## Usage

Open the `.mysql-notebook` file in a MySQL-compatible notebook environment or database client to execute the queries and explore the ecommerce database.