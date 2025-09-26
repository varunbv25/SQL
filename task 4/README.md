# Task 4 - Aggregate Functions and Grouping

This directory contains SQL exercises focused on aggregate functions and data grouping for summarizing tabular data.

## Files

- `task4.mysql-notebook` - MySQL notebook for aggregate functions and grouping exercises

## Objective

Use aggregate functions and grouping to summarize data from the ecommerce database.

## Database Used

**ecommerce** database with the following tables:
- `Products` - Product catalog with pricing and categories
- `Suppliers` - Supplier information
- `Customers` - Customer records
- `Addresses` - Customer address information
- `Ref_Address_Types` - Address type reference data

## SQL Concepts Covered

### 1. Basic Aggregate Functions
- `COUNT(*)` - Count total records
- `AVG()` - Calculate averages on numeric columns
- `SUM()` - Sum numeric values
- `MIN()/MAX()` - Find minimum and maximum values

### 2. GROUP BY Clauses
- Categorize data by specific columns
- Group products by type and supplier
- Analyze data by categories
- Multi-column grouping

### 3. HAVING Clauses
- Filter grouped results
- Apply conditions to aggregated data
- Complex filtering on grouped data
- Multiple HAVING conditions

### 4. Advanced Grouping Techniques
- JOIN operations with GROUP BY
- CASE statements for custom categorization
- Percentage calculations within groups
- Complex multi-table aggregation

## Key Query Examples

1. **Basic Counts**: Total products, customers
2. **Price Analysis**: Average, min, max prices by category
3. **Category Summaries**: Product counts and values by type
4. **Supplier Analysis**: Products supplied and total values
5. **Filtered Groups**: Categories with specific criteria
6. **Price Ranges**: Custom categorization with CASE
7. **Cross-table Analysis**: JOIN with grouping

## Tools Required

- MySQL Workbench
- DB Browser for SQLite (alternative)
- MySQL Command Line Client

## Usage Instructions

1. Open `task4.mysql-notebook` in your MySQL client
2. Ensure connection to the `ecommerce` database
3. Execute queries individually to see results
4. Modify parameters to explore different data groupings

## Expected Outcomes

After completing these exercises, you will be able to:
- Apply aggregate functions to numeric columns
- Use GROUP BY to categorize and summarize data
- Filter grouped data using HAVING clauses
- Analyze and summarize tabular data effectively
- Combine multiple tables with grouping for complex analysis