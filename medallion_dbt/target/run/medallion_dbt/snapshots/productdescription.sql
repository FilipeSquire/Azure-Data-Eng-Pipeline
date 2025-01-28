
      
  
    
        create or replace table `hive_metastore`.`snapshot`.`productdescription_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/productdescription/productdescription_snapshot'
      
      
      as
      
    

    select *,
        md5(coalesce(cast(ProductDescriptionID as string ), '')
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
        



with productdescription_snapshot as (
    SELECT
        ProductDescriptionID,
        Description
    from `hive_metastore`.`saleslt`.`productdescription`
)

select * from productdescription_snapshot

    ) sbq



  
  