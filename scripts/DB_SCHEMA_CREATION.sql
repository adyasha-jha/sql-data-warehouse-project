/*
=================================================================================
CREATE DATABASE AND SCHEMAS
=================================================================================

SCRIPT PURPOSE:- 
      This script creates a new databse names 'DataWarehouse' after checking if it already exists.
      If the database exists, it is droppped and recreated.
      Additionally, the script sets up three schemas within the database: 'bronze', 'silver', 'gold'.


WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exits.
    ALL data in the database will be permanently deleted. 
    Proceed with caution and ensure you have proper backup before running this script.
*/


USE master;
GO

--Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN 
  ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE DataWarehouse;
END;

GO
  
--Create the DataWarehouse Database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

--CREATE SCHEMAS

CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO