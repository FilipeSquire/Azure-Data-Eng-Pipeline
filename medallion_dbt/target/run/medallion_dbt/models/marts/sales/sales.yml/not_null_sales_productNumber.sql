select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select productNumber
from `hive_metastore`.`saleslt`.`sales`
where productNumber is null



      
    ) dbt_internal_test