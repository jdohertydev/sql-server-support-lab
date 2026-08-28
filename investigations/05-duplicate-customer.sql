/*
    Investigation 5: Potential duplicate customer accounts

    Scenario:
    A fictional customer reports that order history appears to be split
    across two accounts.

    Goal:
    Identify duplicate-looking records and check dependent orders before
    considering any change.
*/

USE B2BSupportLab;
GO

-- Find company names that occur more than once.
SELECT
    company_name,
    COUNT(*) AS duplicate_count
FROM dbo.Customers
GROUP BY company_name
HAVING COUNT(*) > 1;

-- Inspect the suspected duplicate records.
SELECT *
FROM dbo.Customers
WHERE company_name = 'Dragon Office Supplies';

-- Check the orders linked to both customer IDs.
SELECT *
FROM dbo.Orders
WHERE customer_id IN (101, 106)
ORDER BY customer_id, order_id;

/*
    Expected evidence:
    - customers 101 and 106 share the same company name and email address;
    - order 5018 belongs to 101;
    - order 5022 belongs to 106.

    This is enough to support further investigation of a duplicate-account
    issue, but a real merge should not be performed until all dependencies,
    business rules, permissions and the approved process are understood.
*/
