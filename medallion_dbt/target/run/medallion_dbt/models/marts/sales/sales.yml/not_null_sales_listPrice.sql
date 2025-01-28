select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select listPrice
from `hive_metastore`.`saleslt`.`sales`
where listPrice is null



      
    ) dbt_internal_test