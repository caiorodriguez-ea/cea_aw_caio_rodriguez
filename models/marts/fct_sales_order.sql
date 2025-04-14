with
    enriched_sales_order as (
        select *
        from {{ ref('int_sales__order') }}
    )

    , dim_product_info as (
        select *
        from {{ ref('dim_product') }}
    )

    , dim_sales_person_info as (
        select *
        from {{ ref('dim_sales_person') }}
    )

    , sales_order_join_dims as (
        select
            {{ dbt_utils.generate_surrogate_key(['pk_sales_order']) }} as sk_sales_order
            , dim_product_info.sk_product
            , dim_sales_person_info.sk_sales_person
            , enriched_sales_order.sk_location
            , enriched_sales_order.sales_order_dt
            , enriched_sales_order.sales_order_due_dt
            , enriched_sales_order.sales_order_ship_dt
            , enriched_sales_order.customer_nm
            , enriched_sales_order.card_type_nm
            , enriched_sales_order.order_qtd
            , enriched_sales_order.unit_price
            , enriched_sales_order.gross_total
            , enriched_sales_order.net_total
            , enriched_sales_order.partial_sales_order_freight_value
            , enriched_sales_order.unit_price_discount
            , enriched_sales_order.partial_sales_order_value
            , enriched_sales_order.partial_sales_order_taxes_value
            , enriched_sales_order.partial_sales_order_total_value
            , enriched_sales_order.order_status
            , enriched_sales_order.is_online_order
        from enriched_sales_order
        left join dim_product_info on enriched_sales_order.fk_product = dim_product_info.pk_product
        left join dim_sales_person_info on enriched_sales_order.fk_sales_person = dim_sales_person_info.pk_sales_person
    )

select *
from sales_order_join_dims