{% snapshot productmodel_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/productmodel/",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='ProductModelID',
        strategy='check',
        check_cols='all'
    )
}}

with productmodel_snapshot as (
    SELECT
        ProductModelID,
        Name,
        CatalogDescription
    from {{source('saleslt','productmodel')}}
)

select * from productmodel_snapshot

{% endsnapshot %}