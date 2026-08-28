/*
    Investigation 1: Customer and order lookup

    Scenario:
    A support request refers to customer 104 and order 5021.

    Goal:
    Confirm the relevant records before drawing any conclusion.
*/

USE B2BSupportLab;
GO

-- Confirm the customer record.
SELECT *
FROM dbo.Customers
WHERE customer_id = 104;

-- Confirm that the reported order belongs to that customer.
SELECT *
FROM dbo.Orders
WHERE order_id = 5021
  AND customer_id = 104;

-- Review the customer's processing orders, newest first.
SELECT *
FROM dbo.Orders
WHERE customer_id = 104
  AND order_status = 'Processing'
ORDER BY order_date DESC;

-- Inspect the line records stored for order 5021.
SELECT *
FROM dbo.OrderLines
WHERE order_id = 5021;
