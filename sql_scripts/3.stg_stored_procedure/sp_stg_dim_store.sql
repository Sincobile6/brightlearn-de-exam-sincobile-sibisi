CREATE OR ALTER PROCEDURE [dbo].[sp_create_stg_dim_supplier]

AS
BEGIN


 IF NOT EXISTS (select * from information_schema.tables where table_name = 'stg_dim_store')



create table [stg_brightlearn_store].[dbo].[stg_dim_store](
    [Store_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[cashier_name] [varchar](50) NULL,
    [store_name] [varchar](50) NULL,
	[store_city] [varchar](50) NULL,
	[store_province] [varchar](50) NULL,
	[store_region] [varchar](50) NULL,
	[store_manager] [varchar](50) NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[stg_dim_store] (
  cashier_name,
  store_name,
  store_city,
  store_province,
  store_region,
  store_manager
             
              )
select distinct
  cashier_name,
  store_name,
  store_city,
  store_province,
  store_region,
  store_manager
from [stg_brightlearn_store].[dbo].[raw_data]

--select all data from dim_date

select* from [stg_brightlearn_store].[dbo].[stg_dim_store]
 END;