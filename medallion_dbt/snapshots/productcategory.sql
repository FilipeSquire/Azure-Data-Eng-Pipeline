{% snapshot productcategory_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "/mnt/silver/productcategory/",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='ProductCategoryID',
        strategy='check',
        check_cols='all'
    )
}}

with productcategory_snapshot as (
    SELECT 
        ProductCategoryID,
        ParentProductCategoryID,
        Name
    from {{source('saleslt','productcategory')}}
)

select * from productcategory_snapshot

{% endsnapshot %}