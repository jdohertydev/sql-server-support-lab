/*
    Investigation 6: Summary and data-quality queries

    A small collection of read-only queries used to practise common
    support-style filtering and aggregation.
*/

USE B2BSupportLab;
GO

-- Which order statuses currently exist?
SELECT DISTINCT order_status
FROM dbo.Orders;

-- Find customers with no stored email address.
SELECT *
FROM dbo.Customers
WHERE email IS NULL;

-- Count orders for one customer.
SELECT COUNT(*) AS order_count
FROM dbo.Orders
WHERE customer_id = 104;

-- Count orders by customer.
SELECT
    customer_id,
    COUNT(*) AS order_count
FROM dbo.Orders
GROUP BY customer_id
ORDER BY customer_id;

-- Calculate the stored total for order 5021.
SELECT SUM(quantity * unit_price) AS order_total
FROM dbo.OrderLines
WHERE order_id = 5021;

-- Example of OR: processing or cancelled orders.
SELECT *
FROM dbo.Orders
WHERE order_status = 'Processing'
   OR order_status = 'Cancelled'
ORDER BY order_date DESC;
