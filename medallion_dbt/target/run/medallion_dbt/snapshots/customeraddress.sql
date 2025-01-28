
      
  
    
        create or replace table `hive_metastore`.`snapshot`.`customeraddress_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/customeraddress/customeraddress_snapshot'
      
      
      as
      
    

    select *,
        md5(coalesce(cast(customerID||'-'||AddressID as string ), '')
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
        



with customeraddress_snapshot as (
    select
        CustomerID,
        AddressID,
        AddressType
    from `hive_metastore`.`saleslt`.`customeraddress`
)

select * from customeraddress_snapshot

    ) sbq



  
  