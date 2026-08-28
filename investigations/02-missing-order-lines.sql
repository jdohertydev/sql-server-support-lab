/*
    Investigation 2: Order exists but appears to have no products

    Scenario:
    Order 5024 is visible, but no product lines appear to be attached to it.

    Goal:
    Confirm the order exists and check whether related OrderLines are stored.
*/

USE B2BSupportLab;
GO

-- Step 1: confirm the order itself exists.
SELECT *
FROM dbo.Orders
WHERE order_id = 5024;

-- Step 2: inspect related order-line rows directly.
SELECT *
FROM dbo.OrderLines
WHERE order_id = 5024;

-- Step 3: quantify the result.
SELECT COUNT(*) AS order_line_count
FROM dbo.OrderLines
WHERE order_id = 5024;

-- Step 4: preserve the order even when no matching line exists.
SELECT
    o.order_id,
    o.customer_id,
    o.order_status,
    ol.order_line_id
FROM dbo.Orders AS o
LEFT JOIN dbo.OrderLines AS ol
    ON o.order_id = ol.order_id
WHERE o.order_id = 5024;

/*
    Expected evidence from the seed data:
    - order 5024 exists;
    - COUNT(*) returns 0;
    - the LEFT JOIN returns the order with order_line_id = NULL.

    This confirms the current stored state. It does not prove why the
    related rows are missing.
*/
