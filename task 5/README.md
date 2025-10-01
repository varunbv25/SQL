# Task 5 - SQL Joins (Inner, Left, Right, Full)

This directory contains SQL exercises focused on mastering different types of SQL joins to combine data from multiple tables.

## Files

- `task_5.mysql-notebook` - MySQL notebook for SQL joins exercises

## Objective

Learn to combine data from multiple related tables using various join types to create comprehensive data views.

## Database Used

**ecommerce** database with the following tables:

### Existing Tables
- `Products` - Product catalog with pricing and categories
- `Suppliers` - Supplier information
- `Customers` - Customer records
- `Addresses` - Customer address information
- `Ref_Address_Types` - Address type reference data

### New Tables Created
- `Orders` - Customer order records
- `Order_Items` - Individual items within orders
- `Customer_Addresses` - Link table between customers and addresses

## SQL Concepts Covered

### 1. INNER JOIN
- Returns only records with matching values in both tables
- Most common join type
- Examples:
  - Products with their Suppliers
  - Customers with their Orders
  - Multi-table joins combining 3+ tables

### 2. LEFT JOIN (LEFT OUTER JOIN)
- Returns all records from left table
- Returns matching records from right table
- Returns NULL for non-matching right table records
- Examples:
  - All Customers with or without Orders
  - All Suppliers with Product counts
  - All Products with Order statistics

### 3. RIGHT JOIN (RIGHT OUTER JOIN)
- Returns all records from right table
- Returns matching records from left table
- Returns NULL for non-matching left table records
- Examples:
  - All Orders with Customer details
  - All Products with Supplier information
  - All Addresses with Customer links

### 4. FULL OUTER JOIN
- Returns all records from both tables
- MySQL doesn't natively support FULL OUTER JOIN
- Simulated using UNION of LEFT and RIGHT joins
- Examples:
  - All Customers and All Orders
  - All Suppliers and All Products
  - Complete data from both sides

### 5. CROSS JOIN
- Cartesian product of two tables
- Every row from first table combined with every row from second
- Used for generating all possible combinations
- Example: Product types with all Suppliers

### 6. SELF JOIN
- Table joined with itself
- Used to find relationships within same table
- Example: Products from the same supplier

## Key Query Examples

1. **Basic INNER JOIN**: Products with Supplier details
2. **Customer Orders**: All customers and their order history
3. **LEFT JOIN**: Customers including those without orders
4. **Supplier Analysis**: Product counts per supplier (including suppliers with no products)
5. **RIGHT JOIN**: All orders with customer information
6. **FULL OUTER JOIN Simulation**: Complete customer and order data
7. **Supplier Performance**: Revenue analysis across suppliers

## Real-World Use Cases

### Customer Analysis
- Find customers who haven't placed orders (LEFT JOIN)
- Analyze customer spending patterns (INNER JOIN with aggregation)
- List all customers with their addresses (LEFT JOIN)

### Inventory Management
- Products that have never been ordered (LEFT JOIN)
- Supplier performance metrics (multiple JOINs)
- Product availability by supplier (INNER JOIN)

### Order Processing
- Complete order details with customer and product info (INNER JOIN)
- Order history for all customers (LEFT JOIN)
- Revenue by product category (JOIN with GROUP BY)

### Address Management
- Customers with multiple addresses (JOIN with COUNT)
- Addresses not linked to any customer (RIGHT JOIN)
- Address types distribution (JOIN with GROUP BY)

## Tools Required

- MySQL Workbench
- DB Browser for SQLite (alternative)
- MySQL Command Line Client

## Usage Instructions

1. Open `task_5.mysql-notebook` in your MySQL client
2. Ensure connection to the `ecommerce` database
3. **Execute table creation queries first** to create Orders, Order_Items, and Customer_Addresses tables
4. **Insert sample data** for the new tables
5. Execute join queries individually to see different join results
6. Compare results between different join types on same tables
7. Modify WHERE clauses and join conditions to explore variations

## Important Notes

- **Order Matters**: Execute table creation and data insertion before running join queries
- **NULL Values**: Pay attention to how different joins handle NULL values
- **Performance**: INNER JOINs are generally faster than OUTER JOINs
- **MySQL Limitation**: FULL OUTER JOIN is simulated using UNION (not native support)
- **Data Integrity**: Foreign keys ensure referential integrity between tables

## Expected Outcomes

After completing these exercises, you will be able to:

- Understand when to use each type of join
- Write INNER JOINs to find matching records across tables
- Use LEFT JOINs to include all records from primary table
- Apply RIGHT JOINs when needed for specific scenarios
- Simulate FULL OUTER JOINs using UNION
- Combine multiple tables in complex queries
- Analyze business data across related tables
- Choose the appropriate join type for specific requirements
- Handle NULL values in join results
- Optimize queries with proper join selection

## Common Join Patterns

### Pattern 1: Master-Detail Relationship
```sql
SELECT master.*, detail.*
FROM master_table master
INNER JOIN detail_table detail ON master.id = detail.master_id;
```

### Pattern 2: Finding Unmatched Records
```sql
SELECT left_table.*
FROM left_table
LEFT JOIN right_table ON left_table.id = right_table.left_id
WHERE right_table.id IS NULL;
```

### Pattern 3: Aggregation with Joins
```sql
SELECT master.name, COUNT(detail.id) as count
FROM master_table master
LEFT JOIN detail_table detail ON master.id = detail.master_id
GROUP BY master.id, master.name;
```

## Practice Tips

1. **Start Simple**: Begin with 2-table INNER JOINs
2. **Visualize**: Draw table relationships before writing queries
3. **Compare Results**: Run same query with different join types
4. **Use Aliases**: Always use table aliases for readability
5. **Check NULL**: Understand how NULLs appear in different joins
6. **Test with Small Data**: Verify logic before scaling
7. **Use EXPLAIN**: Analyze query performance with EXPLAIN

## Troubleshooting

- **Duplicate Records**: Check if you need DISTINCT or proper join conditions
- **Missing Data**: Verify foreign key relationships and data integrity
- **Cartesian Product**: Ensure join conditions are specified (avoid accidental CROSS JOIN)
- **NULL Confusion**: Remember LEFT/RIGHT JOIN can introduce NULLs
- **Performance Issues**: Consider indexes on join columns
