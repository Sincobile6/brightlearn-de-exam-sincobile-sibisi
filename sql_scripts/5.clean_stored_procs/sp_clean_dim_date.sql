CREATE OR ALTER PROCEDURE [dbo].[sp_create_stg_dim_customer]

AS
BEGIN
--create clean_dim_date

 if object_id ('[stg_brightlearn_store].[dbo].[clean_dim_date]') is not null
    drop table [stg_brightlearn_store].[dbo].[clean_dim_date];

  


    CREATE TABLE drop table[stg_brightlearn_store].[dbo].[clean_dim_date]
    ([dateID] INT IDENTITY(1,1) PRIMARY KEY,
    [transaction_date] [varchar](50) NULL,
    [load_date] DATETIME DEFAULT GETDATE()
    );
  
    INSERT INTO [stg_brightlearn_store].[dbo].[clean_dim_date]( 
    transaction_date
)
SELECT 
    
    COALESCE(
        TRY_CONVERT(DATE,  transaction_date, 101), 
        TRY_CONVERT(DATE,  transaction_date, 103), 
        TRY_CONVERT(DATE,  transaction_date, 111),
        TRY_CONVERT(DATE,  transaction_date, 120),
        TRY_PARSE( transaction_date AS DATE)       
    ) AS  transaction_date

FROM [stg_brightlearn_store].[dbo].[clean_dim_date]

    --view data in table
select *
from  [stg_brightlearn_store].[dbo].[clean_dim_date]

end;