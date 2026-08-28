# SQL Server Support Lab

A self-directed learning project created to develop introductory practical familiarity with **Microsoft SQL Server** and **SQL Server Management Studio (SSMS)** in a technical-support context.

The lab uses a small, fictional B2B ecommerce database containing customers, products, orders and order lines. The focus is not application development or advanced database administration. Instead, the exercises model the kinds of data checks and support investigations that may be useful when troubleshooting customer-reported software or data issues.

## Purpose

The project is intended to document hands-on learning in:

- connecting to and working with a local SQL Server instance through SSMS;
- understanding tables, rows, columns, primary keys and foreign keys;
- retrieving and filtering records with `SELECT`, `WHERE`, `AND`, `OR`, `IN`, `LIKE` and `IS NULL`;
- sorting and summarising data with `ORDER BY`, `DISTINCT`, `COUNT`, `SUM`, `GROUP BY` and `HAVING`;
- combining related data with `INNER JOIN` and `LEFT JOIN`;
- investigating missing or inconsistent related records;
- comparing stored transactional data with current reference data;
- identifying potential duplicate customer records;
- practising cautious data changes with `UPDATE`, `DELETE`, transactions, verification and `ROLLBACK` / `COMMIT`.

## Environment

- Microsoft SQL Server 2025 Developer edition
- SQL Server Management Studio 22
- Local development instance
- Windows Authentication

SQL Server Developer edition is being used only for learning and local development/testing.

## Simplified data model

The lab database contains four core tables:

- `Customers` — customer account information;
- `Products` — product catalogue information;
- `Orders` — order headers linked to customers;
- `OrderLines` — individual products and quantities linked to orders.

Key relationships:

- `Orders.customer_id` → `Customers.customer_id`
- `OrderLines.order_id` → `Orders.order_id`
- `OrderLines.product_id` → `Products.product_id`

All organisations, email addresses, products, orders and scenarios in this repository are fictional and created only for learning purposes.

## Support-style investigations practised

### 1. Customer and order lookup

Used straightforward `SELECT` and `WHERE` queries to confirm whether reported customer or order records existed and whether an order belonged to the expected customer.

### 2. Missing customer data

Used `IS NULL` to identify a customer record with no stored email address, then practised a targeted update using a specific `WHERE` condition and verified the result afterwards.

### 3. Duplicate customer records

Investigated two customer records with the same company name and email address, confirmed that order history was split across the two customer IDs, and considered the risks of treating a duplicate as a simple delete operation.

The exercise reinforced that a real merge should first identify all dependent records and should follow the application's authorised merge or administration process where available.

### 4. Missing order lines

Confirmed that an order existed but had no related rows in `OrderLines`. A `LEFT JOIN` was then used to retain the order record while showing that no matching order-line record existed.

This demonstrated the difference between confirming the current database state and proving the root cause of a customer-reported problem.

### 5. Inactive product on a historical order

Joined `OrderLines` to `Products` to confirm that a historical order referenced a product that is currently inactive.

The important conclusion was that current product status does **not** prove the historical order is corrupt. The product may have been active when the order was placed and deactivated later.

### 6. Stored price versus current catalogue price

Compared the price stored on an order line with the product's current catalogue price. The values differed, but the exercise deliberately avoided assuming this represented an error: possible explanations could include a historical price, discount or customer-specific pricing.

This reinforced a central support principle: SQL can confirm stored values, but those values alone do not necessarily establish the root cause.

## Safe data-change practice

The project treats data modification as a controlled activity rather than the first troubleshooting step.

Practices used include:

1. investigate with read-only `SELECT` queries first;
2. verify the target server and database;
3. use the intended `WHERE` condition in a `SELECT` before running an `UPDATE` or `DELETE`;
4. make only narrowly scoped changes;
5. use transactions when practising changes;
6. inspect the result before choosing `COMMIT` or `ROLLBACK`;
7. verify the final state after a change;
8. recognise that direct database changes in a real application may bypass business rules, audit logging, caches or integrations and therefore require authorisation and an approved process.

## Transaction exercise

A duplicate-customer scenario was used to practise transactions. Orders linked to a duplicate customer ID were reassigned to the chosen surviving customer inside a transaction. The result was inspected and then rolled back during the first attempt.

A second controlled exercise repeated the change, verified the affected records, removed the duplicate customer record and committed the transaction in the local fictional database.

The purpose of the exercise was to understand scope checking, verification and recovery — not to model a production-ready customer-merge procedure.

## Learning status

This project represents **introductory hands-on familiarity**, not professional SQL Server experience.

At this stage I can:

- navigate SSMS and run queries against a SQL Server database;
- understand a simple relational schema;
- write and understand straightforward support queries;
- use filters, aggregates and basic joins;
- investigate missing and potentially inconsistent data;
- understand the difference between current database evidence and root cause;
- recognise the risks of data modification and the value of transactions and verification.

I am still developing fluency in writing more complex SQL independently, particularly multi-table joins and more advanced SQL Server features.

## Planned repository structure

```text
sql-server-support-lab/
├── README.md
├── setup/
│   ├── 01-create-tables.sql
│   └── 02-seed-data.sql
├── investigations/
│   ├── 01-order-lookup.sql
│   ├── 02-missing-order-lines.sql
│   ├── 03-product-status.sql
│   ├── 04-pricing-investigation.sql
│   └── 05-duplicate-customer.sql
├── safe-changes/
│   └── duplicate-customer-merge.sql
└── notes/
    └── learning-notes.md
```

The SQL scripts will be added in small, documented steps so that the repository remains reproducible and the reasoning behind each investigation is visible.
