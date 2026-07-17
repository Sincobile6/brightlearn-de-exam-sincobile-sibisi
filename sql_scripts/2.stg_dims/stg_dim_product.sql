IF NOT EXISTS (select * from information_schema.tables where table_name = 'stg_dim_product')



create table drop table [dwh_brightlearn_store].[dbo].[dwh_dim_product](
    [Product_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[product_name] [varchar](50) NULL,
	[category] [varchar](50) NULL,
	[sub_category] [varchar](50) NULL,
	[sku] [varchar](50) NULL,
    [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[stg_dim_product] (
  product_name,
  category,
  sub_category,
  sku
  
             
              )
select 
  product_name,
  category,
  sub_category,
  sku
  
from [stg_brightlearn_store].[dbo].[raw_data]


---view data in table 

select * 
from [stg_brightlearn_store].[dbo].[stg_dim_product]
