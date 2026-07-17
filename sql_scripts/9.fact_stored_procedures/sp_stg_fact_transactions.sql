CREATE OR ALTER PROCEDURE [dbo].[sp_create_stg_fact_transactions]

AS
BEGIN



if object_id ('[dwh_brightlearn_store].[dbo].[stg_fact_transactions]') is not null
    

 


    CREATE TABLE [stg_brightlearn_store].[dbo].[stg_fact_transactions](
    [Transaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[transaction_amount] [varchar](50) NULL,
	[transaction_discount] [varchar](50) NULL,
	[unit_price] [varchar](50) NULL,
	[cost_price] [varchar](50) NULL,
	[qty] [varchar](50) NULL,
	[line_amount] [varchar](50) NULL,
	[stock_on_hand] [varchar](50) NULL,
	[reorder_threshold] [varchar](50) NULL,
    [load_date] DATETIME DEFAULT GETDATE()
    );

   

   

    INSERT INTO [stg_brightlearn_store].[dbo].[stg_fact_transactions](
    
	transaction_amount,
	transaction_discount,
	unit_price,
	cost_price,
	qty,
	line_amount,
	stock_on_hand,
	reorder_threshold  )

SELECT distinct
transaction_amount,
	transaction_discount,
	unit_price,
	cost_price,
	qty,
	line_amount,
	stock_on_hand,
	reorder_threshold  
	
	
FROM [stg_brightlearn_store].[dbo]. [raw_data]
---view data in table 
select *
from [stg_brightlearn_store].[dbo].[stg_fact_transactions]


end;