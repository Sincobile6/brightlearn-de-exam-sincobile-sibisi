

IF OBJECT_ID('[dwh_brightlearn_store].[dbo].[dwh_fact_transactions]', 'U') IS NOT NULL

    DROP TABLE [dwh_brightlearn_store].[dbo].[dwh_fact_transactions];


CREATE TABLE [dwh_brightlearn_store].[dbo].[dwh_fact_transactions](
    [Transaction_ID] INT IDENTITY(1,1) PRIMARY KEY,
    [Store_ID] INT NOT NULL,
    [Product_ID] INT NOT NULL,
    [Customer_ID] INT NOT NULL,
    [Supplier_ID] INT NOT NULL,
    [Payment_ID] INT NOT NULL,
    [Date_ID] INT NOT NULL,
    [transaction_amount] DECIMAL(18,2) NULL,
    [transaction_discount] DECIMAL(18,2) NULL,
    [unit_price] DECIMAL(18,2) NULL,
    [cost_price] DECIMAL(18,2) NULL,
    [qty] DECIMAL(18,2) NULL,
    [line_amount] DECIMAL(18,2) NULL,
    [stock_on_hand] DECIMAL(18,2) NULL,
    [reorder_threshold] DECIMAL(18,2) NULL,
    [load_date] DATETIME DEFAULT GETDATE(),
    CONSTRAINT fk_store FOREIGN KEY (Store_ID) REFERENCES [dwh_brightlearn_store].[dbo].[dwh_dim_store](Store_ID),
    CONSTRAINT fk_product FOREIGN KEY (Product_ID) REFERENCES [dwh_brightlearn_store].[dbo].[dwh_dim_product](Product_ID),
    CONSTRAINT fk_customer FOREIGN KEY (Customer_ID) REFERENCES [dwh_brightlearn_store].[dbo].[dwh_dim_customer](Customer_ID),
    CONSTRAINT fk_supplier FOREIGN KEY (Supplier_ID) REFERENCES [dwh_brightlearn_store].[dbo].[dwh_dim_supplier](Supplier_ID),
    CONSTRAINT fk_payment FOREIGN KEY (Payment_ID) REFERENCES [dwh_brightlearn_store].[dbo].[dwh_dim_payment](Payment_ID),
    CONSTRAINT fk_date FOREIGN KEY (Date_ID) REFERENCES [dwh_brightlearn_store].[dbo].[dwh_dim_date](Date_ID)
);
GO

INSERT INTO [dwh_brightlearn_store].[dbo].[dwh_fact_transactions](
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
    cle.Store_ID,
    cle.Product_ID,
    cle.Customer_ID,
    cle.Supplier_ID,
    cle.Payment_ID,
    cle.Date_ID,
    cle.transaction_amount,
    cle.transaction_discount,
    cle.unit_price,
    cle.cost_price,
    cle.qty,
    cle.line_amount,
    cle.stock_on_hand,
    cle.reorder_threshold
FROM [stg_brightlearn_store].[dbo].[clean_fact_transactions] AS cle
INNER JOIN [dwh_brightlearn_store].[dbo].[dwh_dim_store] AS sto
    ON sto.Store_ID = cle.Store_ID
INNER JOIN [dwh_brightlearn_store].[dbo].[dwh_dim_product] AS pro
    ON pro.Product_ID = cle.Product_ID
INNER JOIN [dwh_brightlearn_store].[dbo].[dwh_dim_customer] AS cust
    ON cust.Customer_ID = cle.Customer_ID
INNER JOIN [dwh_brightlearn_store].[dbo].[dwh_dim_supplier] AS sup
    ON sup.Supplier_ID = cle.Supplier_ID
INNER JOIN [dwh_brightlearn_store].[dbo].[dwh_dim_payment] AS pay
    ON pay.Payment_ID = cle.Payment_ID
INNER JOIN [dwh_brightlearn_store].[dbo].[dwh_dim_date] AS d
    ON d.Date_ID = cle.Date_ID;
GO

SELECT *
FROM [dwh_brightlearn_store].[dbo].[dwh_fact_transactions];