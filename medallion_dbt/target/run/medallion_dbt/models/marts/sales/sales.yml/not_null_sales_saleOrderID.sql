select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select saleOrderID
from `hive_metastore`.`saleslt`.`sales`
where saleOrderID is null



      
    ) dbt_internal_test