/*
    Investigation 3: Inactive product on a historical order

    Scenario:
    Order 5018 contains an Ergonomic Mouse that is no longer active
    in the current product catalogue.

    Goal:
    Confirm which product is stored on the order and its current status.
*/

USE B2BSupportLab;
GO

-- Join order lines to the current product catalogue.
SELECT
    ol.order_id,
    ol.product_id,
    p.product_name,
    ol.quantity,
    p.is_active
FROM dbo.OrderLines AS ol
INNER JOIN dbo.Products AS p
    ON ol.product_id = p.product_id
WHERE ol.order_id = 5018;

-- Check whether there are other products containing "Mouse" in the name.
SELECT *
FROM dbo.Products
WHERE product_name LIKE '%Mouse%';

/*
    In this lab, BIT value 1 means active and 0 means inactive.

    Evidence:
    - order 5018 references product 204, Ergonomic Mouse;
    - product 204 is currently inactive;
    - no second Mouse product exists in the seeded catalogue.

    Limitation:
    Current status does not tell us what the product status was when
    the historical order was created. Audit/history data would be needed
    to establish that.
*/
