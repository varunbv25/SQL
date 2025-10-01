# Task 6: Subqueries and Nested Queries

## Objective
Master the use of subqueries in SQL for advanced query logic and data retrieval patterns.

## Tools Used
- MySQL Workbench
- DB Browser for SQLite (compatible)

## Concepts Covered

### 1. Scalar Subqueries
Subqueries that return a single value.
- Finding products priced above average
- Comparing individual records to aggregate values
- Using subqueries with comparison operators (=, >, <, etc.)

### 2. Subqueries with IN Operator
Subqueries that return multiple values for membership testing.
- Finding products from suppliers with multiple products
- Identifying customers in cities with multiple residents
- Filtering based on sets of values

### 3. Subqueries with EXISTS
Efficient existence checking without returning actual data.
- Finding customers who have placed orders
- Identifying suppliers with expensive products
- Finding products that have never been ordered (NOT EXISTS)
- Checking related records existence

### 4. Correlated Subqueries
Subqueries that reference columns from the outer query.
- Finding products priced above average for their category
- Comparing records to group-specific aggregates
- Finding the most expensive product per supplier
- Row-by-row comparisons with related data

### 5. Subqueries in SELECT Clause
Using subqueries to calculate derived columns.
- Showing customer order counts
- Calculating times a product has been ordered
- Computing total spending per customer
- Adding calculated fields to result sets

### 6. Subqueries in FROM Clause (Derived Tables)
Using query results as virtual tables.
- Price range categorization and analysis
- Top spending customer identification
- Supplier performance metrics
- Monthly order summaries

### 7. Complex Nested Subqueries
Multiple levels of subquery nesting.
- Using ALL operator (greater than all values)
- Using ANY operator (less than any value)
- Finding customers who ordered from multiple suppliers
- Identifying second-highest values

### 8. Subqueries with Comparison Operators
Advanced comparisons using subquery results.
- Finding maximum-priced products per category
- Identifying above-average spenders
- Comparing to calculated benchmarks

### 9. Subqueries with LIMIT
Combining subqueries with result limiting.
- Top 3 most expensive ordered products
- Customers with most orders
- Ranking and limiting results

### 10. Practical Business Queries
Real-world applications of subqueries.
- Identifying underperforming products
- VIP customer identification (top 25% spenders)
- Profit potential analysis

## Key SQL Patterns

### Pattern 1: Scalar Subquery in WHERE
```sql
SELECT * FROM Products
WHERE product_price > (SELECT AVG(product_price) FROM Products);
```

### Pattern 2: Correlated Subquery
```sql
SELECT p.* FROM Products p
WHERE p.product_price > (
    SELECT AVG(p2.product_price)
    FROM Products p2
    WHERE p2.product_type_code = p.product_type_code
);
```

### Pattern 3: Subquery in SELECT
```sql
SELECT c.customer_name,
       (SELECT COUNT(*) FROM Orders o WHERE o.customer_id = c.customer_id) AS order_count
FROM Customers c;
```

### Pattern 4: Derived Table in FROM
```sql
SELECT * FROM (
    SELECT customer_id, SUM(amount) AS total
    FROM Orders
    GROUP BY customer_id
) AS customer_totals
WHERE total > 1000;
```

## Tables Used
Based on the ECommerce database from Tasks 1-5:
- **Ref_Address_Types** - Address type reference data
- **Suppliers** - Product suppliers
- **Products** - Product catalog
- **Customers** - Customer information
- **Addresses** - Address details
- **Orders** - Customer orders (Task 5)
- **Order_Items** - Order line items (Task 5)
- **Customer_Addresses** - Customer-address relationships (Task 5)

## Learning Outcomes
After completing this task, you will be able to:
- Write scalar subqueries for single-value comparisons
- Use IN, EXISTS, and NOT EXISTS operators with subqueries
- Create correlated subqueries that reference outer query data
- Implement subqueries in SELECT, FROM, and WHERE clauses
- Use ALL and ANY operators for set comparisons
- Build complex multi-level nested queries
- Apply subqueries to solve real-world business problems
- Optimize query performance using appropriate subquery types

## Performance Considerations
- **EXISTS vs IN**: EXISTS is often faster for checking existence
- **Correlated vs Non-correlated**: Non-correlated subqueries execute once, correlated execute for each row
- **Derived tables**: May require temporary storage, consider indexing
- **Subquery in SELECT**: Executes for each row, use cautiously with large datasets

## Common Use Cases
1. **Filtering by aggregates**: Find records above/below averages
2. **Existence checking**: Identify records with/without related data
3. **Ranking**: Find top N records based on calculations
4. **Complex calculations**: Multi-step computations using derived tables
5. **Data validation**: Check for orphaned or missing relationships

## Tips and Best Practices
- Use EXISTS instead of IN when checking for existence
- Limit correlated subquery usage for large datasets
- Consider JOINs as alternatives for better performance
- Use EXPLAIN to analyze subquery execution plans
- Name derived tables clearly for readability
- Avoid unnecessary nesting levels

## Deliverables
- `task_6.mysql-notebook` - MySQL Workbook with all subquery examples
- All queries demonstrate scalar, correlated, and nested subqueries
- Queries use IN, EXISTS, ALL, ANY operators
- Examples cover SELECT, FROM, and WHERE clause subqueries

## Query Categories Summary
- **10 categories** of subquery patterns
- **30+ example queries** demonstrating various techniques
- **Scalar, correlated, and nested** subquery types
- **Practical business scenarios** with real-world applications
