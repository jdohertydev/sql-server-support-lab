/*
    SQL Server Support Lab
    Step 1: Create the four core tables.

    Run this against a fresh B2BSupportLab database.
*/

USE B2BSupportLab;
GO

CREATE TABLE dbo.Customers (
    customer_id INT PRIMARY KEY,
    company_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(150) NULL,
    account_status NVARCHAR(20) NOT NULL
);
GO

CREATE TABLE dbo.Products (
    product_id INT PRIMARY KEY,
    product_name NVARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    is_active BIT NOT NULL
);
GO

CREATE TABLE dbo.Orders (
    order_id INT PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status NVARCHAR(20) NOT NULL,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (customer_id)
        REFERENCES dbo.Customers(customer_id)
);
GO

CREATE TABLE dbo.OrderLines (
    order_line_id INT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_OrderLines_Orders
        FOREIGN KEY (order_id)
        REFERENCES dbo.Orders(order_id),
    CONSTRAINT FK_OrderLines_Products
        FOREIGN KEY (product_id)
        REFERENCES dbo.Products(product_id)
);
GO
