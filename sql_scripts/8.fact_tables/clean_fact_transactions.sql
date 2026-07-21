

IF OBJECT_ID('[stg_brightlearn_store].[dbo].[clean_fact_transactions]', 'U') IS NOT NULL
    DROP TABLE [stg_brightlearn_store].[dbo].[clean_fact_transactions];

CREATE TABLE [stg_brightlearn_store].[dbo].[clean_fact_transactions](
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

INSERT INTO [stg_brightlearn_store].[dbo].[clean_fact_transactions](
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
SELECT
    stg.Store_ID,
    stg.Product_ID,
    stg.Customer_ID,
    stg.Supplier_ID,
    stg.Payment_ID,
    stg.Date_ID,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.transaction_amount)), '')) AS transaction_amount,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.transaction_discount)), '')) AS transaction_discount,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.unit_price)), '')) AS unit_price,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.cost_price)), '')) AS cost_price,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.qty)), '')) AS qty,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.line_amount)), '')) AS line_amount,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.stock_on_hand)), '')) AS stock_on_hand,
    TRY_CONVERT(DECIMAL(18,2), NULLIF(LTRIM(RTRIM(stg.reorder_threshold)), '')) AS reorder_threshold
FROM [stg_brightlearn_store].[dbo].[stg_fact_transactions] AS stg;
GO

SELECT *
FROM [stg_brightlearn_store].[dbo].[clean_fact_transactions];

