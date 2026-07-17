CREATE OR ALTER PROCEDURE [dbo].[sp_create_clean_dim_payment]

AS
BEGIN
IF NOT EXISTS (select * from information_schema.tables where table_name = '[clean_dim_payment]')



create table [stg_brightlearn_store].[dbo].[clean_dim_payment](
    [Payment_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[payment_method] [varchar](50) NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[clean_dim_payment] (
  payment_method
             
              )
select 
  payment_method
  
from [stg_brightlearn_store].[dbo].[stg_dim_payment]


---view data in table 

select * 
from [stg_brightlearn_store].[dbo].[clean_dim_payment]
 END;