select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select customerID
from `hive_metastore`.`saleslt`.`sales`
where customerID is null



      
    ) dbt_internal_test