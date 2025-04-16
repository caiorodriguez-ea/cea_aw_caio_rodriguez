with
    sales_order_reason_info as (
        select *
        from {{ ref('int_sales__agg_order_reason') }}
    )

    , dim_product_info as (
        select *
        from {{ ref('dim_product') }}
    )

    , dim_sales_reason_info as (
        select *
        from {{ ref('dim_sales_reason') }}
    )
    , sales_reason_aggregated as (
        select
            fk_sales_reason
            , fk_product
            , sk_location
            , sales_order_dt
            , count(distinct pk_sales_order) as total_orders
            , sum(order_qtd) as total_quantity
            , sum(gross_total) as total_gross
            , sum(net_total) as total_net
        from sales_order_reason_info
        group by 
            fk_sales_reason
            , fk_product
            , sk_location
            , sales_order_dt
    )

    , agg_sales_order_reason_join_dims as (
        select
            dim_sales_reason_info.sk_sales_reason
            , dim_product_info.sk_product
            , sales_reason_aggregated.sk_location
            , sales_reason_aggregated.sales_order_dt
            , sales_reason_aggregated.total_orders
            , sales_reason_aggregated.total_quantity
            , sales_reason_aggregated.total_gross
            , sales_reason_aggregated.total_net
        from sales_reason_aggregated
        left join dim_product_info on sales_reason_aggregated.fk_product = dim_product_info.pk_product
        left join dim_sales_reason_info on sales_reason_aggregated.fk_sales_reason = dim_sales_reason_info.pk_sales_reason
        where sk_sales_reason is not null
    )

    , sales_order_reason_gen_unique_key as (
        select
            {{ dbt_utils.generate_surrogate_key(['sk_sales_reason', 'sk_product', 'sk_location', 'sales_order_dt']) }} as sk_reason_product_location
            , *
        from agg_sales_order_reason_join_dims
    )

select *
from sales_order_reason_gen_unique_key