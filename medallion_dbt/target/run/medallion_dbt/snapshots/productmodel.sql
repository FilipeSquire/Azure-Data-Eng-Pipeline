
      
  
    
        create or replace table `hive_metastore`.`snapshot`.`productmodel_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/productmodel/productmodel_snapshot'
      
      
      as
      
    

    select *,
        md5(coalesce(cast(ProductModelID as string ), '')
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
        



with productmodel_snapshot as (
    SELECT
        ProductModelID,
        Name,
        CatalogDescription
    from `hive_metastore`.`saleslt`.`productmodel`
)

select * from productmodel_snapshot

    ) sbq



  
  