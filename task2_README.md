# ECommerce Database Operations - Task 2

## Overview
This document describes all database operations performed on the ECommerce database as documented in `task_2.mysql-notebook`.

## Database Structure
The ECommerce database contains the following tables:
- `Ref_Address_Types` (6 records)
- `Suppliers` (7 records)
- `Products` (9 records)
- `Customers` (8 records)
- `Addresses` (8 records)

## Operations Performed

### 1. Data Insertion (INSERT)

#### Address Types
- Added 3 new address types:
  - `WORK`: Work Address (billing and delivery enabled)
  - `PO_BOX`: Post Office Box (delivery only)
  - `TEMP`: Temporary Address (delivery only)

#### Suppliers
- Added 4 new suppliers:
  - Sports Equipment Co (ID: 5)
  - Kitchen Essentials Ltd (ID: 6)
  - Digital Media Corp (ID: 7)
  - Eco-Friendly Products (ID: 8)

#### Products
- Added 6 new products across different categories:
  - Professional Basketball (SPORTS)
  - Stainless Steel Cookware Set (KITCHEN)
  - Premium Mobile App (DIGITAL)
  - Bamboo Cutting Board Set (ECO)
  - Smart Watch (ELECTRONICS)
  - Web Development Guide (BOOKS)

#### Customers
- Added 5 new customers:
  - David Lee (Tech startup founder)
  - Lisa Chen (Faculty member)
  - Robert Garcia (Gym owner)
  - Anna Taylor
  - James Wilson (Corporate procurement manager)

#### Addresses
- Added 5 new addresses for the new customers across various US cities

### 2. Data Updates (UPDATE)

#### Price Updates
- Increased all ELECTRONICS product prices by 10%

#### Customer Management
- Updated customer ID 1 to VIP status with priority shipping
- Updated email domains from @company.com to @newcompany.com

#### Supplier Certification
- Added ISO 9001 certification to suppliers 1, 2, and 4

#### Address Management
- Updated address ID 2 with new business district information
- Updated billing address type description for invoice processing

#### Product Enhancement
- Marked products 2 and 3 as bestselling items with 5-star ratings
- Added "Premium Product Line" designation to products over $200

### 3. Data Deletion (DELETE)

#### Product Cleanup
- Removed Digital Media product (ID: 7)
- Removed all products from supplier 7 (Digital Media Corp)

#### Address Cleanup
- Removed addresses with no details where address_id > 7

#### Customer Cleanup
- Removed customers with no details where customer_id > 5

#### Reference Data Cleanup
- Removed temporary address type (TEMP)
- Removed Digital Media Corp supplier (ID: 7)

### 4. Data Queries (SELECT)

#### Summary Reports
- Generated record count summary for all tables
- Listed all electronics products ordered by price (descending)
- Found VIP/Priority customers
- Listed ISO 9001 certified suppliers

#### Full Table Views
- Retrieved complete data from all tables ordered by ID

## Final Database State
After all operations, the database contains:
- **Address Types**: 6 records (BILLING, HOME, OFFICE, PO_BOX, SHIPPING, WORK)
- **Suppliers**: 7 active suppliers (removed Digital Media Corp)
- **Products**: 9 products (removed digital product)
- **Customers**: 8 customers (removed customers without details)
- **Addresses**: 8 addresses (cleaned up incomplete records)

## Key Business Rules Applied
1. Electronics products received price increases
2. Premium products (>$200) marked as premium line
3. VIP customers receive priority treatment
4. ISO 9001 certification tracked for quality suppliers
5. Incomplete records were cleaned up for data integrity