# Task 8: Stored Procedures and Functions

## Objective
Learn reusable SQL blocks by creating stored procedures and functions with parameters and conditional logic.

## Database
`ecommerce` database (using tables and data from Tasks 1-7)

---

## Stored Procedures and Functions

### 1. Stored Procedure: Add New Order with Validation

**Purpose:** Creates a new order after validating customer exists

```sql
DELIMITER $$
CREATE PROCEDURE AddNewOrder(
    IN p_customer_id INT,
    IN p_order_date DATE,
    IN p_order_status VARCHAR(50),
    OUT p_order_id INT
)
BEGIN
    -- Check if customer exists
    IF EXISTS (SELECT 1 FROM Customers WHERE customer_id = p_customer_id) THEN
        -- Get next order ID
        SELECT IFNULL(MAX(order_id), 0) + 1 INTO p_order_id FROM Orders;

        -- Insert new order
        INSERT INTO Orders (order_id, customer_id, order_date, order_status)
        VALUES (p_order_id, p_customer_id, p_order_date, p_order_status);

        SELECT CONCAT('Order ', p_order_id, ' created successfully') AS message;
    ELSE
        SET p_order_id = -1;
        SELECT 'Error: Customer does not exist' AS message;
    END IF;
END$$
DELIMITER ;
```

**Test Query:**
```sql
CALL AddNewOrder(1, '2024-10-05', 'Processing', @new_order_id);
SELECT @new_order_id AS created_order_id;
```

**Expected Output:**
```
+------------------------------------+
| message                            |
+------------------------------------+
| Order 7 created successfully       |
+------------------------------------+

+------------------+
| created_order_id |
+------------------+
|                7 |
+------------------+
```

---

### 2. Function: Calculate Total Order Amount

**Purpose:** Returns the total amount for a specific order

```sql
DELIMITER $$
CREATE FUNCTION GetOrderTotal(p_order_id INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_amount DECIMAL(10,2);

    SELECT IFNULL(SUM(quantity * item_price), 0)
    INTO total_amount
    FROM Order_Items
    WHERE order_id = p_order_id;

    RETURN total_amount;
END$$
DELIMITER ;
```

**Test Query:**
```sql
SELECT GetOrderTotal(1) AS order_total;
```

**Expected Output:**
```
+-------------+
| order_total |
+-------------+
|      379.97 |
+-------------+
```
*Order 1 has: 1 × Headphones (329.99) + 2 × Book (24.99 each) = 379.97*

---

### 3. Stored Procedure: Update Product Price with Percentage

**Purpose:** Increases or decreases product price by a given percentage

```sql
DELIMITER $$
CREATE PROCEDURE UpdateProductPrice(
    IN p_product_id INT,
    IN p_percentage DECIMAL(5,2)
)
BEGIN
    DECLARE v_old_price DECIMAL(10,2);
    DECLARE v_new_price DECIMAL(10,2);

    -- Get current price
    SELECT product_price INTO v_old_price
    FROM Products
    WHERE product_id = p_product_id;

    -- Calculate new price
    SET v_new_price = v_old_price * (1 + p_percentage / 100);

    -- Update price
    UPDATE Products
    SET product_price = v_new_price
    WHERE product_id = p_product_id;

    SELECT p_product_id AS product_id,
           v_old_price AS old_price,
           v_new_price AS new_price,
           p_percentage AS percentage_change;
END$$
DELIMITER ;
```

**Test Query:**
```sql
CALL UpdateProductPrice(1, 10.00);
```

**Expected Output:**
```
+------------+-----------+-----------+-------------------+
| product_id | old_price | new_price | percentage_change |
+------------+-----------+-----------+-------------------+
|          1 |    329.99 |    362.99 |             10.00 |
+------------+-----------+-----------+-------------------+
```

---

### 4. Function: Get Customer Order Count

**Purpose:** Returns the number of orders placed by a customer

```sql
DELIMITER $$
CREATE FUNCTION GetCustomerOrderCount(p_customer_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE order_count INT;

    SELECT COUNT(*)
    INTO order_count
    FROM Orders
    WHERE customer_id = p_customer_id;

    RETURN order_count;
END$$
DELIMITER ;
```

**Test Query:**
```sql
SELECT GetCustomerOrderCount(1) AS order_count;
```

**Expected Output:**
```
+-------------+
| order_count |
+-------------+
|           2 |
+-------------+
```
*Customer 1 (John Smith) has 2 orders*

---

### 5. Stored Procedure: Get Customer Purchase Summary

**Purpose:** Provides comprehensive purchase analytics for a customer

```sql
DELIMITER $$
CREATE PROCEDURE GetCustomerPurchaseSummary(IN p_customer_id INT)
BEGIN
    SELECT
        c.customer_id,
        c.customer_name,
        c.customer_email,
        COUNT(DISTINCT o.order_id) AS total_orders,
        IFNULL(SUM(oi.quantity * oi.item_price), 0) AS total_spent,
        IFNULL(AVG(oi.quantity * oi.item_price), 0) AS avg_order_value
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
    WHERE c.customer_id = p_customer_id
    GROUP BY c.customer_id, c.customer_name, c.customer_email;
END$$
DELIMITER ;
```

**Test Query:**
```sql
CALL GetCustomerPurchaseSummary(1);
```

**Expected Output:**
```
+-------------+---------------+-----------------------+--------------+-------------+-----------------+
| customer_id | customer_name | customer_email        | total_orders | total_spent | avg_order_value |
+-------------+---------------+-----------------------+--------------+-------------+-----------------+
|           1 | John Smith    | john.smith@email.com  |            2 |     1039.96 |          346.65 |
+-------------+---------------+-----------------------+--------------+-------------+-----------------+
```

---

### 6. Function: Calculate Product Discount Price

**Purpose:** Calculates discounted price for a product

```sql
DELIMITER $$
CREATE FUNCTION CalculateDiscountPrice(
    p_product_id INT,
    p_discount_percent DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE original_price DECIMAL(10,2);
    DECLARE discount_price DECIMAL(10,2);

    SELECT product_price INTO original_price
    FROM Products
    WHERE product_id = p_product_id;

    SET discount_price = original_price * (1 - p_discount_percent / 100);

    RETURN discount_price;
END$$
DELIMITER ;
```

**Test Query:**
```sql
SELECT product_id, product_price,
       CalculateDiscountPrice(product_id, 15.00) AS discounted_price
FROM Products
WHERE product_id = 1;
```

**Expected Output:**
```
+------------+---------------+------------------+
| product_id | product_price | discounted_price |
+------------+---------------+------------------+
|          1 |        329.99 |           280.49 |
+------------+---------------+------------------+
```
*15% discount on $329.99 = $280.49*

---

### 7. Stored Procedure: Process Order Cancellation with Conditional Logic

**Purpose:** Cancels an order with business rule validation

```sql
DELIMITER $$
CREATE PROCEDURE CancelOrder(IN p_order_id INT)
BEGIN
    DECLARE v_order_status VARCHAR(50);

    -- Get current order status
    SELECT order_status INTO v_order_status
    FROM Orders
    WHERE order_id = p_order_id;

    -- Check if order can be cancelled
    IF v_order_status IS NULL THEN
        SELECT 'Error: Order does not exist' AS message;
    ELSEIF v_order_status = 'Delivered' THEN
        SELECT 'Error: Cannot cancel delivered order' AS message;
    ELSEIF v_order_status = 'Cancelled' THEN
        SELECT 'Warning: Order is already cancelled' AS message;
    ELSE
        UPDATE Orders
        SET order_status = 'Cancelled'
        WHERE order_id = p_order_id;

        SELECT CONCAT('Order ', p_order_id, ' has been cancelled') AS message;
    END IF;
END$$
DELIMITER ;
```

**Test Query:**
```sql
CALL CancelOrder(4);
```

**Expected Output:**
```
+-------------------------------+
| message                       |
+-------------------------------+
| Order 4 has been cancelled    |
+-------------------------------+
```

**Test with Delivered Order:**
```sql
CALL CancelOrder(1);
```

**Expected Output:**
```
+---------------------------------------+
| message                               |
+---------------------------------------+
| Error: Cannot cancel delivered order  |
+---------------------------------------+
```

---

### 8. Function: Check Product Availability

**Purpose:** Returns availability status of a product

```sql
DELIMITER $$
CREATE FUNCTION IsProductAvailable(p_product_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE product_exists INT;

    SELECT COUNT(*) INTO product_exists
    FROM Products
    WHERE product_id = p_product_id;

    IF product_exists = 0 THEN
        RETURN 'Not Found';
    ELSE
        RETURN 'Available';
    END IF;
END$$
DELIMITER ;
```

**Test Query:**
```sql
SELECT product_id, IsProductAvailable(product_id) AS availability
FROM Products
LIMIT 5;
```

**Expected Output:**
```
+------------+--------------+
| product_id | availability |
+------------+--------------+
|          1 | Available    |
|          2 | Available    |
|          3 | Available    |
|          4 | Available    |
|          5 | Available    |
+------------+--------------+
```

---

### 9. Stored Procedure: Get Top Customers by Spending

**Purpose:** Returns top N customers ranked by total spending

```sql
DELIMITER $$
CREATE PROCEDURE GetTopCustomers(IN p_limit INT)
BEGIN
    SELECT
        c.customer_id,
        c.customer_name,
        c.customer_email,
        COUNT(DISTINCT o.order_id) AS total_orders,
        IFNULL(SUM(oi.quantity * oi.item_price), 0) AS total_spent
    FROM Customers c
    LEFT JOIN Orders o ON c.customer_id = o.customer_id
    LEFT JOIN Order_Items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id, c.customer_name, c.customer_email
    HAVING total_spent > 0
    ORDER BY total_spent DESC
    LIMIT p_limit;
END$$
DELIMITER ;
```

**Test Query:**
```sql
CALL GetTopCustomers(3);
```

**Expected Output:**
```
+-------------+---------------+---------------------------+--------------+-------------+
| customer_id | customer_name | customer_email            | total_orders | total_spent |
+-------------+---------------+---------------------------+--------------+-------------+
|           1 | John Smith    | john.smith@email.com      |            2 |     1039.96 |
|           3 | Michael Brown | mbrown@newcompany.com     |            1 |      449.00 |
|           5 | David Lee     | david.lee@techstart.com   |            1 |      349.48 |
+-------------+---------------+---------------------------+--------------+-------------+
```

---

### 10. Function: Get Supplier Product Count

**Purpose:** Returns the number of products supplied by a supplier

```sql
DELIMITER $$
CREATE FUNCTION GetSupplierProductCount(p_supplier_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE product_count INT;

    SELECT COUNT(*)
    INTO product_count
    FROM Products
    WHERE supplier_id = p_supplier_id;

    RETURN product_count;
END$$
DELIMITER ;
```

**Test Query:**
```sql
SELECT supplier_id, supplier_name,
       GetSupplierProductCount(supplier_id) AS product_count
FROM Suppliers;
```

**Expected Output:**
```
+-------------+------------------------+---------------+
| supplier_id | supplier_name          | product_count |
+-------------+------------------------+---------------+
|           1 | TechCorp Electronics   |             2 |
|           2 | Global Fashion Ltd     |             1 |
|           3 | BookWorld Publishing   |             2 |
|           4 | HomeComfort Inc        |             1 |
|           5 | Sports Equipment Co    |             1 |
|           6 | Kitchen Essentials Ltd |             1 |
|           8 | Eco-Friendly Products  |             1 |
+-------------+------------------------+---------------+
```

---

## Key Concepts Demonstrated

### Stored Procedures
1. **Parameters**: IN, OUT parameter types
2. **Conditional Logic**: IF-ELSE statements for business rules
3. **Data Validation**: Checking existence before operations
4. **Complex Operations**: Multi-step processes with variables
5. **Output**: Both result sets and OUT parameters

### Functions
1. **Return Types**: DECIMAL, INT, VARCHAR
2. **DETERMINISTIC**: Keyword for functions with consistent outputs
3. **Calculations**: Aggregate operations and mathematical computations
4. **Reusability**: Can be used in SELECT statements
5. **Business Logic**: Encapsulating common calculations

### Best Practices
- Use DELIMITER to change statement delimiter when creating procedures/functions
- Declare variables with appropriate data types
- Use meaningful parameter names with prefixes (p_ for parameters, v_ for variables)
- Include error handling and validation
- Return meaningful messages for user feedback
- Use IFNULL/COALESCE for NULL handling

---

## Outcome
Successfully created modular SQL logic that can be:
- **Reused** across multiple queries and applications
- **Maintained** centrally in the database
- **Called** with different parameters for flexibility
- **Tested** independently for reliability
- **Integrated** into application code for consistent business logic

---

## Tables Used
- `Customers` - Customer information
- `Orders` - Order records
- `Order_Items` - Line items for orders
- `Products` - Product catalog
- `Suppliers` - Supplier information

## Tools
- MySQL Workbench / Database Client
- MySQL 8.0+ (for stored procedure and function support)
