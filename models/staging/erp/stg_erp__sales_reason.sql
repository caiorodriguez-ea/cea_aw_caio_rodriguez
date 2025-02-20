with
    sales_reason as (
        select
            cast(salesreasonid as int) as pk_sales_reason
            , cast(modifieddate as date) as sales_reason_update_date
            , initcap(name) as sales_reason_name
            , initcap(reasontype) as sales_reason_type
        from {{ source('erp', 'salesreason') }}
    )

select *
from sales_reason