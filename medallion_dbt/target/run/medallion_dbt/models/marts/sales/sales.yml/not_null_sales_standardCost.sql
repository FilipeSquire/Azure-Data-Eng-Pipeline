select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select standardCost
from `hive_metastore`.`saleslt`.`sales`
where standardCost is null



      
    ) dbt_internal_test