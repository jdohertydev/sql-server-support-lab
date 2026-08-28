/*
    SQL Server Support Lab
    Step 2: Insert fictional B2B ecommerce data.

    The data deliberately includes conditions that can be investigated later:
    - customer 103 has no stored email;
    - customers 101 and 106 are potential duplicates;
    - product 204 is inactive but appears on a historical order;
    - order 5022 stores a price different from the current catalogue price;
    - order 5024 has no order lines.
*/

USE B2BSupportLab;
GO

INSERT INTO dbo.Customers
    (customer_id, company_name, email, account_status)
VALUES
    (101, 'Dragon Office Supplies', 'orders@dragonoffice.example', 'Active'),
    (102, 'Cymru Industrial Ltd', 'purchasing@cymruindustrial.example', 'Active'),
    (103, 'Valley Tech Solutions', NULL, 'Active'),
    (104, 'Bridgend Business Systems', 'accounts@bridgendbs.example', 'Active'),
    (105, 'Red Kite Distribution', 'sales@redkite.example', 'Inactive'),
    (106, 'Dragon Office Supplies', 'orders@dragonoffice.example', 'Active');
GO

INSERT INTO dbo.Products
    (product_id, product_name, unit_price, is_active)
VALUES
    (201, 'Wireless Keyboard', 29.99, 1),
    (202, 'USB-C Docking Station', 89.99, 1),
    (203, '24-inch Monitor', 149.99, 1),
    (204, 'Ergonomic Mouse', 24.99, 0),
    (205, 'Laptop Stand', 39.99, 1);
GO

INSERT INTO dbo.Orders
    (order_id, customer_id, order_date, order_status)
VALUES
    (5018, 101, '2026-08-20', 'Shipped'),
    (5019, 102, '2026-08-22', 'Processing'),
    (5020, 103, '2026-08-23', 'Shipped'),
    (5021, 104, '2026-08-24', 'Processing'),
    (5022, 106, '2026-08-25', 'Shipped'),
    (5023, 105, '2026-08-26', 'Cancelled'),
    (5024, 104, '2026-08-27', 'Processing');
GO

INSERT INTO dbo.OrderLines
    (order_line_id, order_id, product_id, quantity, unit_price)
VALUES
    (7001, 5018, 201, 2, 29.99),
    (7002, 5018, 204, 1, 24.99),
    (7003, 5019, 202, 1, 89.99),
    (7004, 5019, 205, 3, 39.99),
    (7005, 5020, 203, 2, 149.99),
    (7006, 5021, 201, 1, 29.99),
    (7007, 5021, 205, 1, 39.99),
    (7008, 5022, 202, 1, 79.99),
    (7009, 5023, 201, 1, 29.99);
GO
