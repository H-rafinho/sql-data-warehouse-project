/*

===============================================
Create Database and Schemas
===============================================

Script Purpose:
  This scrip creates a new database named 'OnlineShop' after checking if it already exists.
  If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas
  within the database: 'bronze', 'silver' and 'gold'.

WARNING:
  Running this script will drop the entire 'OnlineShop' database if it exists.
  All data in the database will be permanently deleted. Proceed with caution
  and ensure you have proper backups before runnig this script.

*/

USE master;
GO

-- Drop and recreate the 'OnlineShop' databse
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'OnlineShop')
BEGIN
  ALTER DATABSE OnlineShop SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABSE OnlineShop
END;
GO

-- Create the 'OnlineShop' database
CREATE DATABASE OnlineShop;
GO
  
USE OnlineShop;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
