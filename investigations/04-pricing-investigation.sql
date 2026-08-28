/*
    Investigation 4: Stored order price versus current catalogue price

    Scenario:
    The price stored on order 5022 for product 202 differs from the
    product's current catalogue price.

    Goal:
    Display both values side by side without assuming the difference is an error.
*/

USE B2BSupportLab;
GO

SELECT
    ol.order_id,
    ol.product_id,
    p.product_name,
    ol.unit_price AS order_price,
    p.unit_price AS catalogue_price
FROM dbo.OrderLines AS ol
INNER JOIN dbo.Products AS p
    ON ol.product_id = p.product_id
WHERE ol.order_id = 5022
  AND ol.product_id = 202;

/*
    Expected evidence:
    - stored order price: 79.99
    - current catalogue price: 89.99

    The query confirms a difference. It does not establish root cause.
    Possible explanations could include a historical price, discount,
    customer-specific pricing or a later catalogue change.
*/
