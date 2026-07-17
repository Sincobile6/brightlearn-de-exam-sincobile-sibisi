if object_id ('[dwh_brightlearn_store].[dbo].[clean_fact_transactions]') is not null
    drop table [dwh_brightlearn_store].[dbo].[clean_fact_transactions];

    go


    CREATE TABLE [stg_brightlearn_store].[dbo].[clean_fact_transactions](
    [Transaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
	[Store_ID] INT ,
	[Product_ID] INT,
	[Customer_ID] INT,
	[Supplier_ID] INT,
	[Payment_ID] INT,
	[DateID] INT,
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

    go  

   

    INSERT INTO [stg_brightlearn_store].[dbo].[clean_fact_transactions](
    
	transaction_amount,
	transaction_discount,
	unit_price,
	cost_price,
	qty,
	line_amount,
	stock_on_hand,
	reorder_threshold  )
SELECT 
ABS(transaction_amount) AS transaction_amount,
	transaction_discount,
	unit_price,
	cost_price,
	qty,
	line_amount,
	stock_on_hand,
	reorder_threshold 
	
	
FROM [stg_brightlearn_store].[dbo].[stg_fact_transactions] 

---view data in table 
select *
from [stg_brightlearn_store].[dbo].[clean_fact_transactions] 

