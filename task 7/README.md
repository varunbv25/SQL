# Task 7 - SQL Views (CREATE VIEW)

## Objective
Learn to create and use views for abstraction, security, and reusable SQL logic.

## Tools Used
- MySQL Workbench
- DB Browser for SQLite (compatible)

## Concepts Covered

### 1. View Creation with CREATE VIEW
- Syntax: `CREATE VIEW view_name AS SELECT ...`
- Creating virtual tables based on SELECT queries
- Encapsulating complex logic into named views

### 2. Views for Abstraction
- Simplifying complex joins into reusable views
- Creating logical data layers
- Hiding implementation details from end users
- Examples:
  - Product catalog with supplier information
  - Customer addresses with full details
  - Complete order details from multiple tables

### 3. Views for Security
- Restricting access to sensitive columns
- Row-level security through WHERE clauses
- Column-level security by excluding fields
- Examples:
  - Customer contacts without sensitive details
  - Order details without pricing information
  - Premium products access restriction

### 4. Views for Reporting
- Pre-aggregated data for dashboards
- Complex calculations encapsulated
- Performance optimization for frequent queries
- Examples:
  - Customer order summaries with totals
  - Supplier performance metrics
  - Product sales statistics

### 5. View Usage Patterns
- Querying views like regular tables
- Using views in JOIN operations
- Filtering view results with WHERE
- Combining multiple views

### 6. View Management
- SHOW FULL TABLES to list views
- DESCRIBE to see view structure
- SHOW CREATE VIEW to see definition
- CREATE OR REPLACE to modify views
- DROP VIEW to remove views

## Database Schema
This task builds upon the **ecommerce** database from Tasks 1-6:

### Existing Tables
- **Ref_Address_Types** - Address type reference data
- **Suppliers** - Product suppliers
- **Products** - Product catalog with pricing
- **Customers** - Customer information
- **Addresses** - Address details
- **Orders** - Customer orders (from Task 5)
- **Order_Items** - Order line items (from Task 5)
- **Customer_Addresses** - Customer-address relationships (from Task 5)

## Views Created

### Security Views
1. **vw_customer_contacts** - Customer info without sensitive details
2. **vw_order_details_no_price** - Order details without financial data
3. **vw_premium_products** - High-value products only (>$200)

### Abstraction Views
4. **vw_product_catalog** - Products with supplier information
5. **vw_customer_addresses** - Customers with full address details
6. **vw_complete_order_details** - Full order information with all relationships
7. **vw_active_customers** - Customers with recent orders

### Reporting Views
8. **vw_customer_order_summary** - Customer analytics with totals
9. **vw_supplier_performance** - Supplier metrics and statistics
10. **vw_product_sales_stats** - Product sales and revenue data

## Key Benefits of Views

### 1. Security & Privacy
- Hide sensitive columns from unauthorized users
- Implement row-level security with WHERE clauses
- Create role-based data access
- Protect confidential information

### 2. Abstraction & Simplification
- Hide complex joins from end users
- Create logical data models
- Simplify frequently used queries
- Provide consistent data access patterns

### 3. Reusability
- Write once, use many times
- Ensure consistent business logic
- Reduce code duplication
- Easier maintenance and updates

### 4. Performance Optimization
- Pre-defined query patterns
- Simplified execution plans
- Reduced query complexity
- Better query optimization by DBMS

### 5. Business Logic Encapsulation
- Implement business rules in database layer
- Centralize calculations and aggregations
- Ensure data consistency
- Version control for data logic

## Usage Examples

### Basic View Query
```sql
SELECT * FROM vw_customer_contacts;
```

### View with Filtering
```sql
SELECT * FROM vw_product_catalog
WHERE product_price > 100;
```

### View in JOIN Operation
```sql
SELECT cos.*, ca.city
FROM vw_customer_order_summary cos
INNER JOIN vw_customer_addresses ca ON cos.customer_id = ca.customer_id;
```

### View with Aggregation
```sql
SELECT supplier_name, SUM(total_inventory_value)
FROM vw_supplier_performance
GROUP BY supplier_name;
```

## Important Notes

### View Characteristics
- Views are **virtual tables** - they don't store data
- Views execute the underlying SELECT query each time
- Views can be queried like regular tables
- Views can include JOINs, WHERE, GROUP BY, etc.

### View Limitations
- Some views are **not updatable** (complex views with JOINs, aggregations)
- Views may have **performance overhead** for complex queries
- Nested views can impact performance
- MySQL has specific rules for updatable views

### Best Practices
- Name views with prefix `vw_` for easy identification
- Document view purpose and usage
- Avoid deeply nested views
- Consider materialized views for heavy aggregations (if supported)
- Use EXPLAIN to analyze view performance
- Keep view definitions simple and focused

## View Management Commands

### List All Views
```sql
SHOW FULL TABLES WHERE Table_type = 'VIEW';
```

### View Structure
```sql
DESCRIBE vw_customer_contacts;
```

### View Definition
```sql
SHOW CREATE VIEW vw_product_catalog;
```

### Modify View
```sql
CREATE OR REPLACE VIEW vw_customer_contacts AS
SELECT customer_id, customer_name FROM Customers;
```

### Delete View
```sql
DROP VIEW IF EXISTS vw_customer_contacts;
```

## Real-World Use Cases

### E-Commerce Platform
- **Product Catalog View**: Combine products with supplier info for website display
- **Customer Dashboard**: Show order history and spending
- **Inventory Reports**: Track product availability and sales

### Security & Access Control
- **Sales Team View**: Access customer contacts without financial data
- **Finance Team View**: Access pricing and revenue without customer details
- **Manager View**: Full access to all data through comprehensive views

### Reporting & Analytics
- **Daily Sales Dashboard**: Pre-aggregated sales metrics
- **Customer Segmentation**: Active vs inactive customers
- **Supplier Performance**: Quality and delivery metrics

## Learning Outcomes

After completing this task, you will be able to:
- Create views using CREATE VIEW statement
- Understand when to use views for abstraction
- Implement security through views
- Build reporting views with aggregations
- Query views like regular tables
- Use views in complex queries with JOINs
- Manage views (create, modify, drop)
- Apply views to real-world business scenarios
- Understand view performance implications
- Choose between views and stored queries

## Files Included

- `task_7.mysql-notebook` - MySQL notebook with all view definitions and usage examples
- `README.md` - This documentation file

## Execution Instructions

1. Open `task_7.mysql-notebook` in MySQL Workbench
2. Ensure connection to the `ecommerce` database
3. **Execute view creation statements** (CREATE VIEW queries)
4. **Execute usage examples** to query the views
5. Verify results for each view
6. Experiment with additional queries using the views
7. Try view management commands (SHOW, DESCRIBE, etc.)

## Sample Output Examples

### vw_customer_contacts
```
customer_id | customer_name  | customer_email
------------|----------------|---------------------------
1           | John Smith     | john.smith@email.com
2           | Sarah Johnson  | sarah.johnson@email.com
```

### vw_customer_order_summary
```
customer_id | customer_name | total_orders | total_items | total_spent
------------|---------------|--------------|-------------|------------
1           | John Smith    | 3            | 8           | 450.00
2           | Sarah Johnson | 1            | 2           | 125.50
```

### vw_supplier_performance
```
supplier_id | supplier_name        | product_count | avg_price | total_value
------------|---------------------|---------------|-----------|-------------
1           | TechCorp Electronics | 3             | 299.99    | 899.97
2           | Global Fashion Ltd   | 2             | 89.50     | 179.00
```

## Tips for Practice

1. **Start Simple**: Create basic views with SELECT * first
2. **Add Complexity**: Gradually add JOINs and WHERE clauses
3. **Test Thoroughly**: Query views with different filters
4. **Compare Performance**: Compare view queries vs direct queries
5. **Experiment**: Try using views in subqueries and JOINs
6. **Document**: Comment your views with business logic
7. **Clean Up**: Drop test views when done practicing

## Common Pitfalls

- **Circular Dependencies**: View A references View B which references View A
- **Too Complex**: Views with many joins can be slow
- **Outdated Logic**: Forgetting to update views when tables change
- **Security Leaks**: Not properly restricting columns in security views
- **Performance**: Using views when direct queries would be faster

## Next Steps

- Explore **materialized views** (if your DBMS supports them)
- Learn about **indexed views** for performance
- Study **updatable views** and their restrictions
- Practice creating views for your own projects
- Combine views with **stored procedures** and **triggers**

## Additional Resources

- MySQL Views Documentation
- View performance optimization techniques
- Materialized views vs regular views
- View security best practices
