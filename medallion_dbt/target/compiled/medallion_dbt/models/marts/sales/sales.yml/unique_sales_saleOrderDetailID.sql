
    
    

select
    saleOrderDetailID as unique_field,
    count(*) as n_records

from `hive_metastore`.`saleslt`.`sales`
where saleOrderDetailID is not null
group by saleOrderDetailID
having count(*) > 1


