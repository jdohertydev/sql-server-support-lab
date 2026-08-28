/*
    Safe-change demo 2: Duplicate-customer merge mechanics

    This demonstrates transaction control in the simplified lab schema.
    It is NOT a production-ready merge procedure.

    Customer 101 is treated as the surviving record.
    Customer 106 is treated as the duplicate.

    The script deliberately ends with ROLLBACK so it is repeatable.
*/

USE B2BSupportLab;
GO

-- Pre-change verification: confirm the two customer records.
SELECT *
FROM dbo.Customers
WHERE customer_id IN (101, 106);

-- Pre-change verification: identify dependent Orders rows.
SELECT *
FROM dbo.Orders
WHERE customer_id IN (101, 106)
ORDER BY customer_id, order_id;

BEGIN TRANSACTION;

-- Reassign the duplicate customer's orders to the surviving customer.
UPDATE dbo.Orders
SET customer_id = 101
WHERE customer_id = 106;

-- Verify the reassignment before removing anything.
SELECT *
FROM dbo.Orders
WHERE customer_id IN (101, 106)
ORDER BY customer_id, order_id;

-- Remove the duplicate only after its known dependency has been reassigned.
DELETE FROM dbo.Customers
WHERE customer_id = 106;

-- Verify the proposed customer state.
SELECT *
FROM dbo.Customers
WHERE customer_id IN (101, 106);

-- Safe default for a public, repeatable learning script.
ROLLBACK;

-- Verify that both customers and their original order ownership are restored.
SELECT *
FROM dbo.Customers
WHERE customer_id IN (101, 106);

SELECT *
FROM dbo.Orders
WHERE customer_id IN (101, 106)
ORDER BY customer_id, order_id;

/*
    Why this is only a lab demonstration:

    A real customer record may have many more dependencies: invoices,
    addresses, quotes, pricing rules, permissions, credits, audit records,
    integrations and other application state. A built-in merge function or
    approved operational procedure should be preferred where available.
*/
