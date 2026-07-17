if object_id ('[dwh_brightlearn_store].[dbo].[dwh_fact_transactions]') is not null
    drop table [dwh_brightlearn_store].[dbo].[dwh_fact_transactions];

    go


    CREATE TABLE [dwh_brightlearn_store].[dbo].[dwh_fact_transactions](
    [Tansaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
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
    constraint fk_Store_ID
               foreign key (store_ID)
               references [dwh_brightlearn_store].[dbo].[dwh_dim_store] (Store_ID),
    constraint fk_Product_ID
               foreign key (Product_ID)
               references [dwh_brightlearn_store].[dbo].[dwh_dim_product] (Product_ID),
    constraint fk_Customer_ID
               foreign key (Customer_ID)
               references [dwh_brightlearn_store].[dbo].[dwh_dim_customer] (Customer_ID),
    constraint fk_supplier_ID
               foreign key (supplier_ID)
               references [dwh_brightlearn_store].[dbo].[dwh_dim_supplier] (supplier_ID),
    constraint fk_payment_ID
               foreign key (payment_ID)
               references [dwh_brightlearn_store].[dbo].[dwh_dim_payment] (payment_ID),
    constraint fk_dateID
               foreign key (dateID)
               references [dwh_brightlearn_store].[dbo].[dwh_dim_date] (DateID),
    [load_date] DATETIME DEFAULT GETDATE()
    );

    go  

   

    INSERT INTO [dwh_brightlearn_store].[dbo].[dwh_fact_transactions](
    store_ID ,
	product_ID,
	customer_ID,
	supplier_ID,
	payment_ID,
	dateID,
	transaction_amount,
	transaction_discount,
	unit_price,
	cost_price,
	qty,
	line_amount,
	stock_on_hand,
	reorder_threshold  )
SELECT DISTINCT
    sto.store_ID ,
	pro.product_ID,
	cust.customer_ID,
	sup.supplier_ID,
	pay.payment_ID,
	d.dateID,
	cle.transaction_amount,
	cle.transaction_discount,
	cle.unit_price,
	cle.cost_price,
	cle.qty,
	cle.line_amount,
	cle.stock_on_hand,
	cle.reorder_threshold
    
FROM [stg_brightlearn_store].[dbo].[clean_fact_transactions] cle

inner join [dwh_brightlearn_store].[dbo].[dwh_dim_store] sto
on sto.Store_ID = cle.Store_ID


inner join [dwh_brightlearn_store].[dbo].[dwh_dim_product] pro
on pro.Product_ID = cle.Product_ID



inner join [dwh_brightlearn_store].[dbo].[dwh_dim_customer] cust
on cust.Customer_ID = cle.Customer_ID



inner join [dwh_brightlearn_store].[dbo].[dwh_dim_supplier] sup
on sup.Supplier_ID= cle.Supplier_ID  

inner join [dwh_brightlearn_store].[dbo].[dwh_dim_payment] pay
on pay.Payment_ID = cle.Payment_ID 

inner join [dwh_brightlearn_store].[dbo].[dwh_dim_date] d
on d.DateID = cle.DateID;


    --view data in table
    select * from [dwh_brightlearn_store].[dbo].[dwh_fact_transactions]