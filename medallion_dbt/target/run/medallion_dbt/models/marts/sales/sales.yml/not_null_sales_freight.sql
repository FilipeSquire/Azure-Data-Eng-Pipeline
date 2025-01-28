select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select freight
from `hive_metastore`.`saleslt`.`sales`
where freight is null



      
    ) dbt_internal_test