--check for Duplicate Records
--stg_dim_customer

select* from [stg_brightlearn_store].[dbo].[stg_dim_customer]
--customer_first_name

select customer_first_name,
count(*) as duplicate
from [stg_brightlearn_store].[dbo].[stg_dim_customer]
group by customer_first_name
having count(*) >1 or customer_first_name is null

--fix
select *
from(
select *,
row_number()over (partition by customer_first_name order by customer_email desc) as flag
from [stg_brightlearn_store].[dbo].[stg_dim_customer])t
where flag =1 


--check for nulls
select 
sum ( case 
when customer_first_name is null 
then 1 
else 0 
end ) as customer_first_name_nulls ,
sum ( case 
when customer_last_name is null 
then 1 
else 0 
end ) as customer_last_name_nulls
,
sum ( case 
when customer_email is null 
then 1 
else 0 
end ) as customer_email_nulls
from [stg_brightlearn_store].[dbo].[stg_dim_customer]

--check blanks

select *
from [stg_brightlearn_store].[dbo].[stg_dim_customer]
where LTRIM(RTRIM(customer_first_name)) =''
or LTRIM(RTRIM(customer_last_name)) = ''
or LTRIM(RTRIM(customer_email)) ='';

--dim_date
select* from [stg_brightlearn_store].[dbo].[stg_dim_date]

--invalid_dates

select *
from [stg_brightlearn_store].[dbo].[stg_dim_date]
where try_cast(transaction_date as DATE) is null
and transaction_date is not null;



--dim_supplier

select supplier,
count(*) as duplicate
from [stg_brightlearn_store].[dbo].[stg_dim_supplier]
group by supplier

--dim_store

select supplier,
count(*) as duplicate
from [stg_brightlearn_store].[dbo].[stg_dim_supplier]
group by supplier


--dim_product

select *
from [stg_brightlearn_store].[dbo].[stg_dim_PRODUCT]
where LTRIM(RTRIM(category)) = ''