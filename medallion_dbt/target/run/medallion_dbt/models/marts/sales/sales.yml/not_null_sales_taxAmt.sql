select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    



select taxAmt
from `hive_metastore`.`saleslt`.`sales`
where taxAmt is null



      
    ) dbt_internal_test