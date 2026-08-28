/*
    Safe-change demo 1: Targeted UPDATE inside a transaction

    This script intentionally ends with ROLLBACK so the seeded starting
    state is restored and the exercise can be repeated.
*/

USE B2BSupportLab;
GO

-- First verify the exact row and current value.
SELECT *
FROM dbo.Customers
WHERE customer_id = 103;

BEGIN TRANSACTION;

UPDATE dbo.Customers
SET email = 'support@valleytech.example'
WHERE customer_id = 103;

-- Verify the proposed change before deciding whether to keep it.
SELECT *
FROM dbo.Customers
WHERE customer_id = 103;

-- Safe default for this repeatable learning script.
ROLLBACK;

-- Confirm that the original state has been restored.
SELECT *
FROM dbo.Customers
WHERE customer_id = 103;

/*
    In a real authorised change, COMMIT would be used only after the
    intended scope and result had been verified and the operational
    procedure allowed the direct database change.
*/
