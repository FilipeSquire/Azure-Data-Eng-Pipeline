{% snapshot salesorderdetail_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/salesorderdetail/",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='SalesOrderDetailID',
        strategy='check',
        check_cols='all'
    )
}}

with salesorderdetail_snapshot as (
    SELECT
        SalesOrderID,
        SalesOrderDetailID,
        OrderQty,
        ProductID,
        UnitPrice,
        UnitPriceDiscount,
        LineTotal
    from {{source('saleslt','salesorderdetail')}}
)

select * from salesorderdetail_snapshot

{% endsnapshot %}