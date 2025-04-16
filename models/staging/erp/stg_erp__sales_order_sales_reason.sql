with
    sales_order_sales_reason_rename as (
        select
            cast(salesorderid as int) as fk_sales_order
            , cast(salesreasonid as int) as fk_sales_reason
            --, cast(modifieddate as date) as updated_at_dt
        from {{ source('erp', 'salesorderheadersalesreason') }}
    )

select *
from sales_order_sales_reason_rename