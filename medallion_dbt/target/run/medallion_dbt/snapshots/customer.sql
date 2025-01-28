
      
  
    
        create or replace table `hive_metastore`.`snapshot`.`customer_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/customer/customer_snapshot'
      
      
      as
      
    

    select *,
        md5(coalesce(cast(CustomerID as string ), '')
         || '|' || coalesce(cast(
    current_timestamp()
 as string ), '')
        ) as dbt_scd_id,
        
    current_timestamp()
 as dbt_updated_at,
        
    current_timestamp()
 as dbt_valid_from,
        
  
  coalesce(nullif(
    current_timestamp()
, 
    current_timestamp()
), null)
  as dbt_valid_to
from (
        



with customer_snapshot as (
    select
        CustomerID,
        NameStyle,
        Title,
        FirstName,
        MiddleName,
        LastName,
        Suffix,
        CompanyName,
        SalesPerson,
        EmailAddress,
        Phone,
        PasswordHash,
        PasswordSalt
    from `hive_metastore`.`saleslt`.`customer`
)

select * from customer_snapshot

    ) sbq



  
  