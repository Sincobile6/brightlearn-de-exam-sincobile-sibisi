IF NOT EXISTS (select * from information_schema.tables where table_name = 'clean_dim_customers')


create table [stg_brightlearn_store].[dbo].[clean_dim_customer](
  [Customer_ID] INT IDENTITY(1,1) PRIMARY KEY,
  [customer_first_name] [varchar](50) NULL,
  [customer_last_name] [varchar](50) NULL,
  [customer_email] [varchar](50) NULL,
  [customer_phone] [varchar](50) NULL,
  [customer_city] [varchar](50) NULL,
  [customer_province] [varchar](50) NULL,
  [customer_loyalty_tier] [varchar](50) NULL,
  [customer_since] [varchar](50) NULL,
  [Load_date] DATETIME DEFAULT GETDATE()
  )

  --insert data into table

  insert into [stg_brightlearn_store].[dbo].[clean_dim_customer] (
              customer_first_name,
              customer_last_name,
              customer_email,
              customer_phone,
              customer_city,
              customer_province,
              customer_loyalty_tier,
              customer_since
              )
select  UPPER(LEFT(customer_first_name, 1)) + LOWER(SUBSTRING(customer_first_name, 2, LEN(customer_first_name))),
             UPPER(LEFT(customer_last_name, 1)) + LOWER(SUBSTRING(customer_last_name, 2, LEN(customer_last_name))),
              customer_email,
              customer_phone,
              customer_city,
              customer_province,
              customer_loyalty_tier,
              customer_since
from(
select *,
row_number()over (partition by customer_first_name order by customer_email desc) as flag
from [stg_brightlearn_store].[dbo].[stg_dim_customer])t
where flag =1 

--select all data from dim_customers

select * from [stg_brightlearn_store].[dbo].[clean_dim_customer]