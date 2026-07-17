CREATE OR ALTER PROCEDURE [dbo].[sp_create_stg_dim_customer]

AS
BEGIN
IF NOT EXISTS (select * from information_schema.tables where table_name = 'stg_dim_date')



create table [stg_brightlearn_store].[dbo].[stg_dim_date](
  [Date_ID] INT IDENTITY(1,1) PRIMARY KEY,
  [transaction_date] [varchar](50) NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[stg_dim_date] (
          transaction_date    
              )
select distinct transaction_date 
from [stg_brightlearn_store].[dbo].[raw_data]

--select all data from dim_date

select* from [stg_brightlearn_store].[dbo].[stg_dim_date]
 END;