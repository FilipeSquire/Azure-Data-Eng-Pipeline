
    
    

select
    salesOrderDetailID as unique_field,
    count(*) as n_records

from `hive_metastore`.`saleslt`.`sales`
where salesOrderDetailID is not null
group by salesOrderDetailID
having count(*) > 1


