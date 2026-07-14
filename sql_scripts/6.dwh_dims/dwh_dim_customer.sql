
IF NOT EXISTS (select * from information_schema.tables where table_name = 'dwh_dim_customers')

drop table [dwh_brightlearn_store].[dbo].[dwh_dim_customer]

create table [dwh_brightlearn_store].[dbo].[dwh_dim_customer](
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