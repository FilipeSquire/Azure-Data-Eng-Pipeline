{% snapshot address_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/address/",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='AddressID',
        strategy='check',
        check_cols='all'
    )
}}

with address_snapshot as (
    select
        AddressID,
        AddressLine1,
        AddressLine2,
        City,
        StateProvince,
        CountryRegion,
        PostalCode
    from {{source('saleslt','address')}}
)

select * from address_snapshot

{% endsnapshot %}