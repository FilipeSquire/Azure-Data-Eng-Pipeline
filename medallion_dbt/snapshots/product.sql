{% snapshot product_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "mnt/silver/product",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='ProductID',
        strategy='check',
        check_cols='all'
    )
}}

with product_snapshot as (
    SELECT
        ProductID,
        Name,
        ProductNumber,
        Color,
        StandardCost,
        ListPrice,
        Size,
        Weight,
        ProductCategoryID,
        ProductModelID,
        SellStartDate,
        SellEndDate,
        DiscontinuedDate,
        ThumbNailPhoto,
        ThumbnailPhotoFileName
    from {{source('saleslt','product')}}
)

select * product_snapshot

{% endsnapshot %}