--TRUNCATE AND INSERT DATA TO AVOID LOADING DATA DUPLICATES

-----------------------------------------------CRM TABLES---------------------------------------------------------
USE DataWarehouse;
GO

CREATE  OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME,  @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '===============================================';
		PRINT 'Loading Bronze Layer';
		PRINT '===============================================';

		PRINT'------------------------------------------------';
		PRINT'Loading CRM Tables';
		PRINT'------------------------------------------------';

		
		SET @start_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;

		PRINT'>>Bulk Inserting Data into Table: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\2adya\Desktop\PROJECTS\Data Warehouse SQL\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + ' seconds';

		PRINT'----------------------';

		SET @end_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT'>>Bulk Inserting Data into Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\2adya\Desktop\PROJECTS\Data Warehouse SQL\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + ' seconds';

		PRINT'---------------------------';

		SET @end_time = GETDATE();
		PRINT'>>Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT'>>Bulk Inserting Data into Table: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\2adya\Desktop\PROJECTS\Data Warehouse SQL\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + ' seconds';

		---------------------------------------------------ERP TABLES-------------------------------------------------------

		PRINT'------------------------------------------------';
		PRINT'Loading ERP Tables';
		PRINT'------------------------------------------------';


		SET @end_time = GETDATE();
		PRINT'>>Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT'>>Bulk Inserting Data into Table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'C:\Users\2adya\Desktop\PROJECTS\Data Warehouse SQL\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + ' seconds';

		PRINT'---------------------------';

		SET @end_time = GETDATE();
		PRINT'>>Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT'>>Bulk Inserting Data into Table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'C:\Users\2adya\Desktop\PROJECTS\Data Warehouse SQL\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + ' seconds';


		PRINT'---------------------------';


		SET @end_time = GETDATE();
		PRINT'>>Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT'>>Bulk Inserting Data into Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'C:\Users\2adya\Desktop\PROJECTS\Data Warehouse SQL\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration: '+ CAST(DATEDIFF(second, @start_time, @end_Time) AS NVARCHAR) + ' seconds';
		

		SET @batch_end_time = GETDATE();
		PRINT '>>Total Bronze Load Duration: '+ CAST(DATEDIFF(second, @batch_start_time, @batch_end_Time) AS NVARCHAR) + ' seconds';

	END TRY
	BEGIN CATCH
		PRINT'=====================================================';
		PRINT'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT'=====================================================';
	END CATCH
END

GO

EXECUTE bronze.load_bronze
