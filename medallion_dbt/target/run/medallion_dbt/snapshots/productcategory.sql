
      
  
    
        create or replace table `hive_metastore`.`snapshot`.`productcategory_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/productcategory/productcategory_snapshot'
      
      
      as
      
    

    select *,
        md5(coalesce(cast(ProductCategoryID as string ), '')
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
        



with productcategory_snapshot as (
    SELECT 
        ProductCategoryID,
        ParentProductCategoryID,
        Name
    from `hive_metastore`.`saleslt`.`productcategory`
)

select * from productcategory_snapshot

    ) sbq



  
  