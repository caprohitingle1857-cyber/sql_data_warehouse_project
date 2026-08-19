/* this stored procedure loads data into the 'bronze' schema from external csv files.*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
   DECLARE @start_time DATETIME, @end_time DATETIME;
   BEGIN TRY
      PRINT'=================================================';
      PRINT 'Loading Bronze Layer';
      PRINT'=================================================';

      PRINT'-------------------------------------------------';
      PRINT 'Loading CRM Tables';
      PRINT'-------------------------------------------------';

     BULK INSERT bronze.crm_cust_info
FROM 'C:\DATA ANALYST\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR=',',
      TABLOCK
     );
     
     PRINT'>> Inserting Data Into:bronze.crm_prd_info '
      BULK INSERT bronze.crm_prd_info
FROM 'C:\DATA ANALYST\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR=',',
      TABLOCK
     );
     
     PRINT'>> Inserting Data Into:bronze.crm_sales_details'
        BULK INSERT bronze.crm_sales_details
FROM 'C:\DATA ANALYST\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR=',',
      TABLOCK
     );
     
     PRINT'-------------------------------------------------';
      PRINT 'Loading ERP Tables';
      PRINT'-------------------------------------------------';

      PRINT'>> Inserting Data Into:bronze.erp_CUST_AZ12'
     BULK INSERT bronze.erp_CUST_AZ12
FROM 'C:\DATA ANALYST\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.CSV'
WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR=',',
      TABLOCK
     );
       
     PRINT'>> Inserting Data Into:bronze.erp_LOC_A101'
      BULK INSERT bronze.erp_LOC_A101
FROM 'C:\DATA ANALYST\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.CSV'
WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR=',',
      TABLOCK
     );
     
     PRINT'>> Inserting Data Into:bronze.erp_PX_CAT_G1V2'
     BULK INSERT bronze.erp_PX_CAT_G1V2
FROM 'C:\DATA ANALYST\SQL\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.CSV'
WITH (
      FIRSTROW = 2,
      FIELDTERMINATOR=',',
      TABLOCK
     );
      
     END TRY 
       BEGIN CATCH
       PRINT'=================================================';
       PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
       PRINT 'Error Messege' + ERROR_MESSEGE();
       PRINT 'Error Messege' + CAST (ERROR_NUMBER() AS NVARCHAR);
       PRINT 'Error Messege' + CAST (ERROR_STATE() AS NVARCHAR);
       PRINT'=================================================';
       END CATCH
END
