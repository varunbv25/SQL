# E-commerce Database Schema

This SQL file creates a basic e-commerce database schema with the following components:

## Tables Created

- **Ref_Address_Types**: Reference table for different address types (billing, shipping, home, office)
  - Primary Key: `address_type_code`
- **Suppliers**: Stores supplier information including name and details
  - Primary Key: `supplier_id`
- **Products**: Product catalog with pricing, linked to suppliers via foreign key
  - Primary Key: `product_id`
  - Foreign Key: `supplier_id` → References `Suppliers(supplier_id)` with CASCADE DELETE
- **Customers**: Customer records with name, email, and additional details
  - Primary Key: `customer_id`
- **Addresses**: Complete address information including building, street, city, zip, and country
  - Primary Key: `address_id`

## Sample Data

The file includes sample data insertions for all tables:
- 4 address types (billing, shipping, home, office)
- 4 suppliers (TechCorp Electronics, Global Fashion Ltd, BookWorld Publishing, HomeComfort Inc)
- 4 customers with email addresses and descriptions
- 4 sample addresses across different US cities
- 4 products from different categories (electronics, clothing, books, furniture)

## Query Operations

The file concludes with SELECT statements to display the contents of all created tables, allowing verification of the data insertion.

## Entity Relationship Diagram

```
┌─────────────────────┐                    ┌─────────────────────┐
│   Suppliers         │                    │   Customers         │
├─────────────────────┤                    ├─────────────────────┤
│ 🔑 supplier_id      │                    │ 🔑 customer_id      │
│   supplier_name     │                    │   customer_name     │
│   other_supplier_   │                    │   customer_email    │
│   details           │                    │   other_customer_   │
└──────────┬──────────┘                    │   details           │
           │                               └─────────────────────┘
           │
           │
           │ (1:Many)
           │
┌──────────▼──────────┐
│   Products          │
├─────────────────────┤
│ 🔑 product_id       │
│   product_type_code │
│ 🔗 supplier_id      │ ────────────────────┐
│   product_price     │                     │
│   other_product_    │                     │
│   details           │                     │
└─────────────────────┘                     │
                                            │
                                            │ FOREIGN KEY
                                            │ ON DELETE CASCADE
                                            │
                                            └─────────────────────┐
                                                                  │
┌─────────────────────┐                    ┌─────────────────────▼┐
│   Addresses         │                    │ Ref_Address_Types    │
├─────────────────────┤                    ├──────────────────────┤
│ 🔑 address_id       │                    │ 🔑 address_type_code │
│   address_line_1_   │                    │   address_type_      │
│   building          │                    │   description        │
│   line_2_number_    │                    │   billing_locations  │
│   street            │                    │   delivery_office    │
│   line_3_area_      │                    └──────────────────────┘
│   locality          │
│   city              │
│   zip_postcode      │
│   state_province_   │
│   country           │
│   iso_country_code  │
│   other_address_    │
│   details           │
└─────────────────────┘
```

🔑 = Primary Key
🔗 = Foreign Key

## Database Relationships

### Primary Keys
- `Ref_Address_Types.address_type_code` (VARCHAR)
- `Suppliers.supplier_id` (INT)
- `Products.product_id` (INT)
- `Customers.customer_id` (INT)
- `Addresses.address_id` (INT)

### Foreign Keys
- `Products.supplier_id` → `Suppliers.supplier_id`
  - Constraint: ON DELETE CASCADE (deleting a supplier removes all their products)

## Key Features

- Referential integrity through foreign key constraints
- Boolean flags in address types for billing and delivery locations
- Proper data types for prices (DECIMAL), emails (VARCHAR with UNIQUE constraint)
- Cascade delete on supplier-product relationship