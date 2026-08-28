# SQL Server Support Lab

A self-directed learning project documenting introductory hands-on work with **Microsoft SQL Server** and **SQL Server Management Studio (SSMS)** in a technical-support context.

The lab uses a small, fictional B2B ecommerce database containing customers, products, orders and order lines. The emphasis is on investigating reported data issues, checking evidence carefully and making controlled changes rather than on advanced database administration.

> This is a learning project. It does **not** represent professional SQL Server experience and is not affiliated with any company. All organisations, email addresses, products, orders and support scenarios are fictional.

## Environment

- Microsoft SQL Server 2025 Developer edition
- SQL Server Management Studio 22
- Local SQL Server instance
- Windows Authentication

SQL Server Developer edition is used only for local learning and development/testing.

## What this project covers

The exercises document practice with:

- `SELECT`, `WHERE`, `AND`, `OR`, `IN`, `LIKE` and `IS NULL`;
- `ORDER BY` and `DISTINCT`;
- `COUNT`, `SUM`, `GROUP BY` and `HAVING`;
- `INNER JOIN` and `LEFT JOIN`;
- primary keys and foreign keys;
- investigating missing related records;
- comparing transactional data with current reference data;
- identifying potential duplicate records;
- targeted `UPDATE` and `DELETE` statements;
- `BEGIN TRANSACTION`, `ROLLBACK` and `COMMIT` concepts;
- verifying scope before and after a data change.

## Data model

The database is named `B2BSupportLab` and contains four tables:

- `Customers` — customer account information;
- `Products` — current product catalogue information;
- `Orders` — order headers linked to customers;
- `OrderLines` — products, quantities and stored prices linked to orders.

Relationships:

```text
Customers (1) ───< Orders (1) ───< OrderLines >─── (1) Products
```

Foreign keys:

- `Orders.customer_id` → `Customers.customer_id`
- `OrderLines.order_id` → `Orders.order_id`
- `OrderLines.product_id` → `Products.product_id`

The seed data deliberately contains several support-style conditions to investigate, including a missing customer email, a duplicate customer account, an order with no order lines, an inactive product on a historical order and a stored order price that differs from the current catalogue price.

## Repository structure

```text
sql-server-support-lab/
├── .gitignore
├── README.md
├── setup/
│   ├── 00-create-database.sql
│   ├── 01-create-tables.sql
│   └── 02-seed-data.sql
├── investigations/
│   ├── 01-customer-and-order-lookup.sql
│   ├── 02-missing-order-lines.sql
│   ├── 03-product-status.sql
│   ├── 04-pricing-investigation.sql
│   ├── 05-duplicate-customer.sql
│   └── 06-summary-and-data-quality.sql
├── safe-changes/
│   ├── 01-update-missing-email-demo.sql
│   └── 02-duplicate-customer-merge-demo.sql
└── notes/
    └── learning-notes.md
```

## Running the lab

1. Connect to the local SQL Server instance in SSMS.
2. Run `setup/00-create-database.sql`.
3. Run `setup/01-create-tables.sql`.
4. Run `setup/02-seed-data.sql`.
5. Work through the scripts in `investigations/`.
6. Review the scripts in `safe-changes/` carefully before running them. They use transactions and intentionally finish with `ROLLBACK` so the original seed state is restored.

The setup scripts are intended for a fresh local lab. If the tables already exist, recreate the lab database before rerunning the full setup.

## Support-style investigations

### Customer and order lookup

Straightforward filters are used to confirm whether reported customer and order records exist and to narrow an investigation to the relevant records.

### Missing order lines

Order `5024` exists but has no related `OrderLines`. A `LEFT JOIN` retains the order record while showing `NULL` on the missing related side.

This establishes the current stored state, but it does not by itself explain why the related rows are absent.

### Inactive product on a historical order

Order `5018` contains product `204`, which is currently inactive. That does not prove the historical order is corrupt: the product may have been active when the order was placed and deactivated later.

### Stored price versus current catalogue price

Order `5022` stores a price of `79.99` for product `202`, while the current catalogue price is `89.99`. The difference is evidence, not automatically an error. A discount, customer-specific price or later catalogue change could explain it.

### Duplicate customer records

Two seeded customer records represent the same fictional company. Their orders are split across the two customer IDs. The investigation confirms the duplication and the dependent order records before any change is considered.

## Safe data-change practice

The project treats modification as a controlled step, not the first troubleshooting action:

1. investigate with read-only queries first;
2. confirm the target server and database;
3. run a `SELECT` with the intended `WHERE` condition before using that condition in an `UPDATE` or `DELETE`;
4. keep changes narrowly scoped;
5. use a transaction for the practice change;
6. inspect the result;
7. choose `ROLLBACK` if the change should not be kept, or `COMMIT` only when intentionally authorised;
8. verify the final state.

In a real application, direct database changes may bypass business rules, audit logging, caches or integrations. An approved application workflow or documented operational procedure should be preferred where one exists.

## Security and privacy

This repository contains only fictional learning data and deliberately does not include production data or credentials.

Do not commit API keys, access tokens, passwords, private keys, production connection strings, real customer data, database backups or local SQL Server database files. The `.gitignore` excludes common local secret files, SQL Server database/back-up files, IDE state and temporary files as an additional safeguard.

The sample email addresses use the reserved `.example` domain so that they cannot accidentally identify or route mail to real organisations.

Git commit authorship remains associated with the GitHub account that owns this portfolio repository; that is intentional and is separate from application or database credentials.

## Learning status

This repository represents **introductory practical familiarity**, not SQL Server proficiency.

At this stage I can navigate SSMS, understand a simple relational schema, write and interpret straightforward support queries, use basic aggregates and joins, and recognise the importance of evidence, scope checking and transactions.

I am still developing fluency in writing more complex SQL independently, particularly joins without scaffolding and more advanced SQL Server features.
