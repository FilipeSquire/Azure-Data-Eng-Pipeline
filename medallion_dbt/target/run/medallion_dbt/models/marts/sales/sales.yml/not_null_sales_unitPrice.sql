select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select unitPrice
from `hive_metastore`.`saleslt`.`sales`
where unitPrice is null



      
    ) dbt_internal_test