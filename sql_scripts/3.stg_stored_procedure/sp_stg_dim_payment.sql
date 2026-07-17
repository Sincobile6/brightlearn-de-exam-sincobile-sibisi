CREATE OR ALTER PROCEDURE [dbo].[sp_create_stg_dim_payment]

AS
BEGIN
IF NOT EXISTS (select * from information_schema.tables where table_name = '[stg_dim_payment]')



create table [stg_brightlearn_store].[dbo].[stg_dim_payment](
    [Payment_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[payment_method] [varchar](50) NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[stg_dim_payment] (
  payment_method
             
              )
select distinct 
  payment_method
  
from [stg_brightlearn_store].[dbo].[raw_data]


---view data in table 

select * 
from [stg_brightlearn_store].[dbo].[stg_dim_payment]
 END;