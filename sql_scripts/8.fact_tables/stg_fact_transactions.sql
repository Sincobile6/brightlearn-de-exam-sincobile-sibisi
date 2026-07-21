

IF OBJECT_ID('[stg_brightlearn_store].[dbo].[stg_fact_transactions]', 'U') IS NOT NULL
    DROP TABLE [stg_brightlearn_store].[dbo].[stg_fact_transactions];

CREATE TABLE [stg_brightlearn_store].[dbo].[stg_fact_transactions](
    [Transaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Store_ID] INT NULL,
    [Product_ID] INT NULL,
    [Customer_ID] INT NULL,
    [Supplier_ID] INT NULL,
    [Payment_ID] INT NULL,
    [Date_ID] INT NULL,
    [transaction_amount] DECIMAL(18,2) NULL,
    [transaction_discount] DECIMAL(18,2) NULL,
    [unit_price] DECIMAL(18,2) NULL,
    [cost_price] DECIMAL(18,2) NULL,
    [qty] DECIMAL(18,2) NULL,
    [line_amount] DECIMAL(18,2) NULL,
    [stock_on_hand] DECIMAL(18,2) NULL,
    [reorder_threshold] DECIMAL(18,2) NULL,
    [load_date] DATETIME DEFAULT GETDATE()
);
GO

INSERT INTO [stg_brightlearn_store].[dbo].[stg_fact_transactions](
    Store_ID,
    Product_ID,
    Customer_ID,
    Supplier_ID,
    Payment_ID,
    Date_ID,
    transaction_amount,
    transaction_discount,
    unit_price,
    cost_price,
    qty,
    line_amount,
    stock_on_hand,
    reorder_threshold
)
SELECT DISTINCT
    sto.Store_ID,
    pro.Product_ID,
    cust.Customer_ID,
    sup.Supplier_ID,
    pay.Payment_ID,
    d.Date_ID,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.transaction_amount)), '')) AS transaction_amount,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.transaction_discount)), '')) AS transaction_discount,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.unit_price)), '')) AS unit_price,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.cost_price)), '')) AS cost_price,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.qty)), '')) AS qty,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.line_amount)), '')) AS line_amount,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.stock_on_hand)), '')) AS stock_on_hand,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(r.reorder_threshold)), '')) AS reorder_threshold
FROM [stg_brightlearn_store].[dbo].[raw_data] AS r
INNER JOIN [stg_brightlearn_store].[dbo].[stg_dim_store] AS sto
    ON sto.store_name = r.store_name
   AND sto.store_city = r.store_city
   AND sto.store_province = r.store_province
   AND sto.store_region = r.store_region
   AND sto.store_manager = r.store_manager
INNER JOIN [stg_brightlearn_store].[dbo].[stg_dim_product] AS pro
    ON pro.product_name = r.product_name
   AND pro.category = r.category
   AND pro.sub_category = r.sub_category
   AND pro.sku = r.sku
INNER JOIN [stg_brightlearn_store].[dbo].[stg_dim_customer] AS cust
    ON cust.customer_first_name = r.customer_first_name
   AND cust.customer_last_name = r.customer_last_name
   AND cust.customer_email = r.customer_email
   AND cust.customer_city = r.customer_city
   AND cust.customer_province = r.customer_province
   AND cust.customer_loyalty_tier = r.customer_loyalty_tier
   AND cust.customer_since = r.customer_since
INNER JOIN [stg_brightlearn_store].[dbo].[stg_dim_supplier] AS sup
    ON sup.supplier = r.supplier
INNER JOIN [stg_brightlearn_store].[dbo].[stg_dim_payment] AS pay
    ON pay.payment_method = r.payment_method
INNER JOIN [stg_brightlearn_store].[dbo].[stg_dim_date] AS d
    ON d.transaction_date = r.transaction_date;
GO

SELECT *
FROM [stg_brightlearn_store].[dbo].[stg_fact_transactions];

