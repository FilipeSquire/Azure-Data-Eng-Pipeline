{% snapshot productdescription_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "mnt/silver/productdescription",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='ProductDescriptionID',
        strategy='check',
        check_cols='all'
    )
}}

with productdescription_snapshot as (
    SELECT
        ProductDescriptionID,
        Description
    from {{source('saleslt','productdescription')}}
)

select * from productdescription_snapshot

{% endsnapshot %}