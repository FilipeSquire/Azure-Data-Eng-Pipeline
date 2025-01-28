select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select saleOrderDetailID
from `hive_metastore`.`saleslt`.`sales`
where saleOrderDetailID is null



      
    ) dbt_internal_test