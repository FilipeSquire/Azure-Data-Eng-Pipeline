
    
    

select
    salesOrderID as unique_field,
    count(*) as n_records

from `hive_metastore`.`saleslt`.`sales`
where salesOrderID is not null
group by salesOrderID
having count(*) > 1


