select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select totalDue
from `hive_metastore`.`saleslt`.`sales`
where totalDue is null



      
    ) dbt_internal_test