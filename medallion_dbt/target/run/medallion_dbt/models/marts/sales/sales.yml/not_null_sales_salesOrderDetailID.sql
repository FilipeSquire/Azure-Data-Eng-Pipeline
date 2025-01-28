select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select salesOrderDetailID
from `hive_metastore`.`saleslt`.`sales`
where salesOrderDetailID is null



      
    ) dbt_internal_test