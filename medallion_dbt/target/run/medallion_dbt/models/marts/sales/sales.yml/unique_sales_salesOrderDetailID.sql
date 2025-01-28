select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    salesOrderDetailID as unique_field,
    count(*) as n_records

from `hive_metastore`.`saleslt`.`sales`
where salesOrderDetailID is not null
group by salesOrderDetailID
having count(*) > 1



      
    ) dbt_internal_test