select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select subTotal
from `hive_metastore`.`saleslt`.`sales`
where subTotal is null



      
    ) dbt_internal_test