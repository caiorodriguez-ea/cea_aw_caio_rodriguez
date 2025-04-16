with
    sales_order_connection_info as (
        select *
        from {{ ref('stg_erp__sales_order_sales_reason') }}
    )

    , sales_reason_info as (
        select *
        from {{ ref('stg_erp__sales_reason') }}
    )

    , sales_order_sales_reason_joined as (
        select
            sales_reason_info.pk_sales_reason
            , sales_order_connection_info.fk_sales_order
            , sales_reason_info.sales_reason_nm
            , sales_reason_info.sales_reason_type
        from sales_order_connection_info
        inner join sales_reason_info on sales_order_connection_info.fk_sales_reason = sales_reason_info.pk_sales_reason
    )

select *
from sales_order_sales_reason_joined