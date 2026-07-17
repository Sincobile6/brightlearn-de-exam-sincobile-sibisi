IF NOT EXISTS (select * from information_schema.tables where table_name = 'stg_dim_supplier')
drop table  [stg_brightlearn_store].[dbo].[stg_dim_supplier]


create table [stg_brightlearn_store].[dbo].[stg_dim_supplier](
  [Supplier_ID] INT IDENTITY(1,1) PRIMARY KEY,
  [supplier] [varchar](50) NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[stg_dim_supplier] (
         supplier   
              )
select distinct supplier
from [stg_brightlearn_store].[dbo].[raw_data]

--select all data from dim_date

select* from [stg_brightlearn_store].[dbo].[stg_dim_supplier]