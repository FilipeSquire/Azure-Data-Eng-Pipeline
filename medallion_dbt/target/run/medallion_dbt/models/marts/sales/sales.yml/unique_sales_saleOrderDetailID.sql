select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
    

select
    saleOrderDetailID as unique_field,
    count(*) as n_records

from `hive_metastore`.`saleslt`.`sales`
where saleOrderDetailID is not null
group by saleOrderDetailID
having count(*) > 1



      
    ) dbt_internal_test