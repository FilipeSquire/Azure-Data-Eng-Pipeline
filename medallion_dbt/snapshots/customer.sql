{% snapshot customer_snapshot %}

{{
    config(
        file_format = "delta",
        location_root = "mnt/silver/customer",
        target_schema = 'snapshot',
        invalidate_hard_deletes=True,
        unique_key='CustomerID',
        strategy='check',
        check_cols='all'
    )
}}

with customer_snapshot as (
    select
        CustomerID,
        NameStyle,
        Title,
        FirstName,
        MiddleName,
        LastName,
        Suffix,
        CompanyName,
        SalesPerson,
        EmailAddress,
        Phone,
        PasswordHash,
        PasswordSalt
    from {{source('saleslt','customer')}}
)

select * from customer_snapshot

{% endsnapshot %}