{% snapshot customeraddress_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "mnt/silver/customeraddress",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key="customerID||'-'||AddressID",
        strategy='check',
        check_cols='all'
    )
}}

with customeraddress_snapshot as (
    select
        CustomerID,
        AddressID,
        AddressType
    from {{source('saleslt','customeraddress')}}
)

select * from customeraddress_snapshot

{% endsnapshot %}