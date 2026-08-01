/*
====================================================
Stored Procedure: Load Bronze Layer (source -> Bronze)
====================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    -  Truncates the bronze tables before loading data.
    -  Uses the BULK.INSERT command to load data from csv Files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Prerequisites:
    - A Master Key must exist in the database.
    - A Database Scoped Credential must be configured with a valid SAS token.
    - An External Data Source must be configured to point to the Azure Blob Storage container.

Usage Example:
    EXEC bronze.load_bronze;
*/

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<YOUR_MASTER_KEY_PASSWORD>';

DROP EXTERNAL DATA SOURCE MyBlobStorage;
DROP DATABASE SCOPED CREDENTIAL MyBlobCredential;

CREATE DATABASE SCOPED CREDENTIAL MyBlobCredential
WITH 
    IDENTITY = 'SHARED ACCESS SIGNATURE',
    SECRET = '<YOUR_SAS_TOKEN>';

CREATE EXTERNAL DATA SOURCE MyBlobStorage
WITH (
    TYPE = BLOB_STORAGE,
    LOCATION = 'https://<storage-account>.blob.core.windows.net/<container-name>',
    CREDENTIAL = MyBlobCredential
);


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
    DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
    BEGIN TRY
        PRINT '=================================';
        PRINT 'Loading Bronze Layer';
        PRINT '=================================';

        PRINT '---------------------------------';
        PRINT 'Table: categories';

        SET @batch_start_time = GETDATE()
        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_categories'
        TRUNCATE table bronze.mock_data_categories

        PRINT '>> Inserting Data Into: bronze.mock_data_categories'
        BULK INSERT bronze.mock_data_categories
        FROM 'categories.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds'; 

        PRINT '---------------------------------';
        PRINT 'Table: customers';

        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_customers'
        TRUNCATE table bronze.mock_data_customers

        PRINT '>> Inserting Data Into: bronze.mock_data_customers'
        BULK INSERT bronze.mock_data_customers
        FROM 'customers.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '---------------------------------';
        PRINT 'Table: employees';

        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_employees'
        TRUNCATE table bronze.mock_data_employees

        PRINT '>> Inserting Data Into: bronze.mock_data_employees'
        BULK INSERT bronze.mock_data_employees
        FROM 'employees.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '---------------------------------';
        PRINT 'Table: suppliers';

        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_suppliers'
        TRUNCATE table bronze.mock_data_suppliers

        PRINT '>> Inserting Data Into: bronze.mock_data_suppliers'
        BULK INSERT bronze.mock_data_suppliers
        FROM 'suppliers.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '---------------------------------';
        PRINT 'Table: order_items';

        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_order_items'
        TRUNCATE table bronze.mock_data_order_items

        PRINT '>> Inserting Data Into: bronze.mock_data_order_items'
        BULK INSERT bronze.mock_data_order_items
        FROM 'order_items.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '---------------------------------';
        PRINT 'Table: orders';

        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_orders'
        TRUNCATE table bronze.mock_data_orders

        PRINT '>> Inserting Data Into: bronze.mock_data_orders'
        BULK INSERT bronze.mock_data_orders
        FROM 'orders.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

        PRINT '---------------------------------';
        PRINT 'Table: products';

        SET @start_time = GETDATE()
        PRINT '>> Truncating Table: bronze.mock_data_products'
        TRUNCATE table bronze.mock_data_products

        PRINT '>> Inserting Data Into: bronze.mock_data_products'
        BULK INSERT bronze.mock_data_products
        FROM 'products.csv'
        WITH (
            DATA_SOURCE = 'MyBlobStorage',
            FORMAT = 'CSV',
            FIRSTROW = 2
        );
        SET @end_time = GETDATE()
        PRINT '>> Load Duration: ' + CAST(DATEDIFF(Second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
        SET @batch_end_time = GETDATE()
        PRINT '===================================='
        PRINT '>> Loading Bronze Layer is Completed:'; 
        PRINT '     - Total Load Duration: ' + CAST(DATEDIFF(Second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds'; 
        PRINT '===================================='   
    END TRY
    BEGIN CATCH
        PRINT '===================================='
        PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
        PRINT 'Error Message' + ERROR_MESSAGE();
        PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
        PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
        PRINT '===================================='
    END CATCH
END
