with
    sales_reason_info as (
        select *
        from {{ ref('int_sales__reason') }}
    )

    , sales_order_info as (
        select *
        from {{ ref('int_sales__order') }}
    )

    , sales_order_joined_info as (
        select
            sales_order_info.pk_sales_order
            , sales_reason_info.pk_sales_reason as fk_sales_reason
            , sales_order_info.fk_product
            , sales_order_info.sk_location
            , sales_order_info.sales_order_dt
            , sales_order_info.order_qtd
            , sales_order_info.gross_total
            , sales_order_info.net_total
        from sales_order_info
        left join sales_reason_info on sales_order_info.pk_sales_order = sales_reason_info.fk_sales_order
    )

select *
from sales_order_joined_info
