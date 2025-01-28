
      
  
    
        create or replace table `hive_metastore`.`snapshot`.`product_snapshot`
      
      using delta
      
      
      
      
      
    location '/mnt/silver/product/product_snapshot'
      
      
      as
      
    

    select *,
        md5(coalesce(cast(ProductID as string ), '')
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
        



with product_snapshot as (
    SELECT
        ProductID,
        Name,
        ProductNumber,
        Color,
        StandardCost,
        ListPrice,
        Size,
        Weight,
        ProductCategoryID,
        ProductModelID,
        SellStartDate,
        SellEndDate,
        DiscontinuedDate,
        ThumbNailPhoto,
        ThumbnailPhotoFileName
    from `hive_metastore`.`saleslt`.`product`
)

select * from product_snapshot

    ) sbq



  
  