/*
    SQL Server Support Lab
    Step 0: Create the local learning database.

    This script is intended for a local SQL Server Developer edition instance.
*/

USE master;
GO

IF DB_ID(N'B2BSupportLab') IS NULL
BEGIN
    CREATE DATABASE B2BSupportLab;
END;
GO

USE B2BSupportLab;
GO
